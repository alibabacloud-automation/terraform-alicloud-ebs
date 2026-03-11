# Dedicated Block Storage Cluster outputs
output "cluster_id" {
  description = "The ID of the EBS dedicated block storage cluster"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].id : null
}

output "cluster_name" {
  description = "The name of the EBS dedicated block storage cluster"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].dedicated_block_storage_cluster_name : null
}

output "cluster_available_capacity" {
  description = "The available capacity of the EBS dedicated block storage cluster in GiB"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].available_capacity : null
}

output "cluster_used_capacity" {
  description = "The used capacity of the EBS dedicated block storage cluster in GiB"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].used_capacity : null
}

output "cluster_status" {
  description = "The status of the EBS dedicated block storage cluster"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].status : null
}

output "cluster_create_time" {
  description = "The creation time of the EBS dedicated block storage cluster"
  value       = var.create_cluster ? alicloud_ebs_dedicated_block_storage_cluster.cluster[0].create_time : null
}

# Enterprise Snapshot Policy outputs
output "snapshot_policy_id" {
  description = "The ID of the EBS enterprise snapshot policy"
  value       = var.create_snapshot_policy ? alicloud_ebs_enterprise_snapshot_policy.policy[0].id : null
}

output "snapshot_policy_name" {
  description = "The name of the EBS enterprise snapshot policy"
  value       = var.create_snapshot_policy ? alicloud_ebs_enterprise_snapshot_policy.policy[0].enterprise_snapshot_policy_name : null
}

output "snapshot_policy_create_time" {
  description = "The creation time of the EBS enterprise snapshot policy"
  value       = var.create_snapshot_policy ? alicloud_ebs_enterprise_snapshot_policy.policy[0].create_time : null
}

# Snapshot Policy Attachment outputs
output "snapshot_policy_attachment_id" {
  description = "The ID of the EBS enterprise snapshot policy attachment"
  value       = var.snapshot_policy_attachment != null ? alicloud_ebs_enterprise_snapshot_policy_attachment.attachment[0].id : null
}

# Disk Replica Pair outputs
output "disk_replica_pair_id" {
  description = "The ID of the EBS disk replica pair"
  value       = var.create_disk_replica_pair && var.disk_replica_pair != null && var.disk_replica_pair.disk_id != "" && var.disk_replica_pair.destination_disk_id != "" && length(alicloud_ebs_disk_replica_pair.pair) > 0 ? alicloud_ebs_disk_replica_pair.pair[0].id : null
}

output "disk_replica_pair_name" {
  description = "The name of the EBS disk replica pair"
  value       = var.create_disk_replica_pair && var.disk_replica_pair != null && var.disk_replica_pair.disk_id != "" && var.disk_replica_pair.destination_disk_id != "" && length(alicloud_ebs_disk_replica_pair.pair) > 0 ? alicloud_ebs_disk_replica_pair.pair[0].disk_replica_pair_name : null
}

output "disk_replica_pair_status" {
  description = "The status of the EBS disk replica pair"
  value       = var.create_disk_replica_pair && var.disk_replica_pair != null && var.disk_replica_pair.disk_id != "" && var.disk_replica_pair.destination_disk_id != "" && length(alicloud_ebs_disk_replica_pair.pair) > 0 ? alicloud_ebs_disk_replica_pair.pair[0].status : null
}

output "disk_replica_pair_create_time" {
  description = "The creation time of the EBS disk replica pair"
  value       = var.create_disk_replica_pair && var.disk_replica_pair != null && var.disk_replica_pair.disk_id != "" && var.disk_replica_pair.destination_disk_id != "" && length(alicloud_ebs_disk_replica_pair.pair) > 0 ? alicloud_ebs_disk_replica_pair.pair[0].create_time : null
}

# Disk Replica Group outputs
output "replica_group_id" {
  description = "The ID of the EBS disk replica group"
  value       = var.create_replica_group ? alicloud_ebs_disk_replica_group.group[0].id : null
}

output "replica_group_name" {
  description = "The name of the EBS disk replica group"
  value       = var.create_replica_group ? alicloud_ebs_disk_replica_group.group[0].disk_replica_group_name : null
}

# Replica Group Drill outputs
output "replica_group_drill_id" {
  description = "The ID of the EBS replica group drill"
  value       = var.create_replica_group_drill ? alicloud_ebs_replica_group_drill.group_drill[0].replica_group_drill_id : null
}

output "replica_group_drill_status" {
  description = "The status of the EBS replica group drill"
  value       = var.create_replica_group_drill ? alicloud_ebs_replica_group_drill.group_drill[0].status : null
}

# Replica Pair Drill outputs
output "replica_pair_drill_id" {
  description = "The ID of the EBS replica pair drill"
  value       = var.replica_pair_drill != null ? alicloud_ebs_replica_pair_drill.pair_drill[0].replica_pair_drill_id : null
}

output "replica_pair_drill_status" {
  description = "The status of the EBS replica pair drill"
  value       = var.replica_pair_drill != null ? alicloud_ebs_replica_pair_drill.pair_drill[0].status : null
}

# Solution Instance outputs
output "solution_instance_id" {
  description = "The ID of the EBS solution instance"
  value       = var.create_solution_instance ? alicloud_ebs_solution_instance.instance[0].id : null
}

output "solution_instance_name" {
  description = "The name of the EBS solution instance"
  value       = var.create_solution_instance ? alicloud_ebs_solution_instance.instance[0].solution_instance_name : null
}

output "solution_instance_status" {
  description = "The status of the EBS solution instance"
  value       = var.create_solution_instance ? alicloud_ebs_solution_instance.instance[0].status : null
}

output "solution_instance_create_time" {
  description = "The creation time of the EBS solution instance"
  value       = var.create_solution_instance ? alicloud_ebs_solution_instance.instance[0].create_time : null
}

# Local values outputs for external reference
output "this_cluster_id" {
  description = "The ID of the EBS cluster (created or external)"
  value       = local.cluster_id
}

output "this_snapshot_policy_id" {
  description = "The ID of the EBS snapshot policy (created or external)"
  value       = local.snapshot_policy_id
}

output "this_replica_group_id" {
  description = "The ID of the EBS replica group (created or external)"
  value       = local.replica_group_id
}