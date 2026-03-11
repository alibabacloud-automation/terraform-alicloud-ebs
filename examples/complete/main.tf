# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Get current region and availability zones
data "alicloud_regions" "current" {
  current = true
}

data "alicloud_ebs_regions" "default" {
  region_id = data.alicloud_regions.current.regions[0].id
}

# Get resource group
data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_ecs_disk" "default" {
  zone_id              = data.alicloud_ebs_regions.default.regions[0].zones[0].zone_id
  category             = "cloud_essd"
  delete_auto_snapshot = "true"
  delete_with_instance = "true"
  description          = var.name
  disk_name            = var.name
  enable_auto_snapshot = "true"
  encrypted            = "true"
  size                 = "500"
  tags = {
    Created      = "TF",
    For          = "example",
    controlledBy = "ear"
  }
}

resource "alicloud_ecs_disk" "destination" {
  zone_id              = data.alicloud_ebs_regions.default.regions[0].zones[1].zone_id
  category             = "cloud_essd"
  delete_auto_snapshot = "true"
  delete_with_instance = "true"
  description          = format("%s-destination", var.name)
  disk_name            = var.name
  enable_auto_snapshot = "true"
  encrypted            = "true"
  size                 = "500"
  tags = {
    Created      = "TF",
    For          = "example",
    controlledBy = "ear"
  }
}

# Example: Create EBS dedicated block storage cluster
module "ebs" {
  source = "../../"

  # Enable cluster creation
  create_cluster = var.create_cluster

  # Enable snapshot policy
  create_snapshot_policy = var.enable_snapshot_policy

  # Snapshot policy configuration
  snapshot_policy_config = var.enable_snapshot_policy ? {
    name        = var.snapshot_policy_name
    description = "Enterprise snapshot policy created by Terraform"
    target_type = "DISK"
    status      = "ENABLED"
    tags = {
      Environment = var.tags.Environment
      ManagedBy   = var.tags.ManagedBy
      Module      = var.tags.Module
    }
    schedule = {
      cron_expression = var.snapshot_cron_expression
    }
    retain_rule = {
      number        = var.snapshot_retain_number
      time_interval = var.snapshot_retain_days
      time_unit     = "DAYS"
    }
  } : null

  # Enable replica group
  create_replica_group = var.enable_replica_group

  # Replica group configuration
  replica_group_config = var.enable_replica_group ? {
    name                  = var.replica_group_name
    description           = "Disk replica group created by Terraform"
    source_region_id      = data.alicloud_regions.current.regions[0].id
    source_zone_id        = data.alicloud_ebs_regions.default.regions[0].zones[0].zone_id
    destination_region_id = data.alicloud_regions.current.regions[0].id
    destination_zone_id   = data.alicloud_ebs_regions.default.regions[0].zones[1].zone_id
    rpo                   = 900
    reverse_replicate     = true
    one_shot              = false
    tags                  = var.tags
  } : null

  # Enable solution instance
  create_solution_instance = var.enable_solution_instance && var.solution_id != ""

  # Solution instance configuration
  solution_instance_config = var.enable_solution_instance && var.solution_id != "" ? {
    name        = var.solution_instance_name
    solution_id = var.solution_id
    description = "EBS solution instance created by Terraform"
    parameters  = var.solution_parameters
  } : null

  # Enable snapshot policy attachment
  create_snapshot_policy_attachment = var.enable_snapshot_policy_attachment && var.snapshot_policy_attachment_disk_id != ""

  # Snapshot policy attachment configuration
  snapshot_policy_attachment = var.enable_snapshot_policy_attachment && var.snapshot_policy_attachment_disk_id != "" ? {
    disk_id = var.snapshot_policy_attachment_disk_id
  } : null

  # Enable disk replica pair
  create_disk_replica_pair = var.enable_disk_replica_pair && var.disk_replica_pair_source_disk_id != "" && var.disk_replica_pair_destination_disk_id != ""

  # Disk replica pair configuration
  disk_replica_pair = var.enable_disk_replica_pair && var.disk_replica_pair_source_disk_id != "" && var.disk_replica_pair_destination_disk_id != "" ? {
    name                  = var.disk_replica_pair_name
    description           = var.disk_replica_pair_description
    destination_disk_id   = alicloud_ecs_disk.destination.id
    destination_region_id = data.alicloud_regions.current.regions[0].id
    destination_zone_id   = alicloud_ecs_disk.destination.zone_id
    disk_id               = alicloud_ecs_disk.default.id
    source_zone_id        = alicloud_ecs_disk.default.zone_id
    payment_type          = var.disk_replica_pair_payment_type
    bandwidth             = var.disk_replica_pair_bandwidth
    rpo                   = var.disk_replica_pair_rpo
    tags                  = var.tags
  } : null

  # Enable replica pair drill
  create_replica_pair_drill = false

  create_replica_group_drill = false

  # Resource group
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids[0]
}