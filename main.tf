# Create dedicated block storage cluster
resource "alicloud_ebs_dedicated_block_storage_cluster" "cluster" {
  count                                = var.create_cluster ? 1 : 0
  dedicated_block_storage_cluster_name = var.cluster_config.name
  description                          = var.cluster_config.description
  total_capacity                       = var.cluster_config.total_capacity
  type                                 = var.cluster_config.type
  zone_id                              = var.cluster_config.zone_id
}

# Create enterprise snapshot policy
resource "alicloud_ebs_enterprise_snapshot_policy" "policy" {
  count                           = var.create_snapshot_policy ? 1 : 0
  enterprise_snapshot_policy_name = var.snapshot_policy_config.name
  desc                            = var.snapshot_policy_config.description
  target_type                     = var.snapshot_policy_config.target_type
  status                          = var.snapshot_policy_config.status
  resource_group_id               = var.resource_group_id
  tags                            = var.snapshot_policy_config.tags

  schedule {
    cron_expression = var.snapshot_policy_config.schedule.cron_expression
  }

  retain_rule {
    number        = var.snapshot_policy_config.retain_rule.number
    time_interval = var.snapshot_policy_config.retain_rule.time_interval
    time_unit     = var.snapshot_policy_config.retain_rule.time_unit
  }

  dynamic "cross_region_copy_info" {
    for_each = var.snapshot_policy_config != null && var.snapshot_policy_config.cross_region_copy_info != null ? [var.snapshot_policy_config.cross_region_copy_info] : []
    content {
      enabled = cross_region_copy_info.value.enabled
      dynamic "regions" {
        for_each = cross_region_copy_info.value.regions != null ? cross_region_copy_info.value.regions : []
        content {
          region_id   = regions.value.region_id
          retain_days = regions.value.retain_days
        }
      }
    }
  }

  dynamic "special_retain_rules" {
    for_each = var.snapshot_policy_config != null && var.snapshot_policy_config.special_retain_rules != null ? [var.snapshot_policy_config.special_retain_rules] : []
    content {
      enabled = special_retain_rules.value.enabled
      dynamic "rules" {
        for_each = special_retain_rules.value.rules != null ? special_retain_rules.value.rules : []
        content {
          special_period_unit = rules.value.special_period_unit
          time_interval       = rules.value.time_interval
          time_unit           = rules.value.time_unit
        }
      }
    }
  }

  dynamic "storage_rule" {
    for_each = var.snapshot_policy_config != null && var.snapshot_policy_config.storage_rule != null ? [var.snapshot_policy_config.storage_rule] : []
    content {
      enable_immediate_access = storage_rule.value.enable_immediate_access
    }
  }
}

# Create snapshot policy attachment
resource "alicloud_ebs_enterprise_snapshot_policy_attachment" "attachment" {
  count = var.create_snapshot_policy_attachment && var.snapshot_policy_attachment != null && var.snapshot_policy_attachment.disk_id != "" ? 1 : 0

  policy_id = local.snapshot_policy_id
  disk_id   = var.snapshot_policy_attachment.disk_id
}

# Create disk replica pair
resource "alicloud_ebs_disk_replica_pair" "pair" {
  count = var.create_disk_replica_pair && var.disk_replica_pair != null && var.disk_replica_pair.disk_id != "" && var.disk_replica_pair.destination_disk_id != "" ? 1 : 0

  disk_replica_pair_name = var.disk_replica_pair.name
  description            = var.disk_replica_pair.description
  destination_disk_id    = var.disk_replica_pair.destination_disk_id
  destination_region_id  = var.disk_replica_pair.destination_region_id
  destination_zone_id    = var.disk_replica_pair.destination_zone_id
  disk_id                = var.disk_replica_pair.disk_id
  source_zone_id         = var.disk_replica_pair.source_zone_id
  payment_type           = var.disk_replica_pair.payment_type
  bandwidth              = var.disk_replica_pair.bandwidth
  rpo                    = var.disk_replica_pair.rpo
  period                 = var.disk_replica_pair.period
  period_unit            = var.disk_replica_pair.period_unit
  resource_group_id      = var.resource_group_id
  reverse_replicate      = var.disk_replica_pair.reverse_replicate
  one_shot               = var.disk_replica_pair.one_shot
  tags                   = var.disk_replica_pair.tags
}

# Create disk replica group
resource "alicloud_ebs_disk_replica_group" "group" {
  count                   = var.create_replica_group ? 1 : 0
  disk_replica_group_name = var.replica_group_config.name
  description             = var.replica_group_config.description
  source_region_id        = var.replica_group_config.source_region_id
  source_zone_id          = var.replica_group_config.source_zone_id
  destination_region_id   = var.replica_group_config.destination_region_id
  destination_zone_id     = var.replica_group_config.destination_zone_id
  rpo                     = var.replica_group_config.rpo
  resource_group_id       = var.resource_group_id
  reverse_replicate       = var.replica_group_config.reverse_replicate
  one_shot                = var.replica_group_config.one_shot
  pair_ids                = var.replica_group_config.pair_ids
  tags                    = var.replica_group_config.tags
}

# Create replica group drill
resource "alicloud_ebs_replica_group_drill" "group_drill" {
  count    = var.create_replica_group_drill ? 1 : 0
  group_id = local.replica_group_id
}

# Create replica pair drill
resource "alicloud_ebs_replica_pair_drill" "pair_drill" {
  count = var.create_replica_pair_drill ? 1 : 0

  pair_id = var.replica_pair_drill.pair_id
}

# Create solution instance
resource "alicloud_ebs_solution_instance" "instance" {
  count                  = var.create_solution_instance && var.solution_instance_config != null && var.solution_instance_config.solution_id != "" ? 1 : 0
  solution_instance_name = var.solution_instance_config.name
  solution_id            = var.solution_instance_config.solution_id
  description            = var.solution_instance_config.description
  resource_group_id      = var.resource_group_id

  dynamic "parameters" {
    for_each = var.solution_instance_config != null ? var.solution_instance_config.parameters : []
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }
}

# Local values for resource ID references
locals {
  # Get cluster ID from created resource or external input
  cluster_id = var.create_cluster && length(alicloud_ebs_dedicated_block_storage_cluster.cluster) > 0 ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].id : var.cluster_id

  # Get snapshot policy ID from created resource or external input
  snapshot_policy_id = var.create_snapshot_policy && length(alicloud_ebs_enterprise_snapshot_policy.policy) > 0 ? alicloud_ebs_enterprise_snapshot_policy.policy[0].id : var.snapshot_policy_id

  # Get replica group ID from created resource or external input
  replica_group_id = var.create_replica_group && length(alicloud_ebs_disk_replica_group.group) > 0 ? alicloud_ebs_disk_replica_group.group[0].id : var.replica_group_id
}