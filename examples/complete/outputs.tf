# EBS Cluster outputs
output "cluster_id" {
  description = "The ID of the EBS dedicated block storage cluster"
  value       = module.ebs.cluster_id
}

output "cluster_name" {
  description = "The name of the EBS dedicated block storage cluster"
  value       = module.ebs.cluster_name
}

output "cluster_available_capacity" {
  description = "The available capacity of the EBS dedicated block storage cluster"
  value       = module.ebs.cluster_available_capacity
}

output "cluster_used_capacity" {
  description = "The used capacity of the EBS dedicated block storage cluster"
  value       = module.ebs.cluster_used_capacity
}

output "cluster_status" {
  description = "The status of the EBS dedicated block storage cluster"
  value       = module.ebs.cluster_status
}

# Snapshot Policy outputs
output "snapshot_policy_id" {
  description = "The ID of the EBS enterprise snapshot policy"
  value       = module.ebs.snapshot_policy_id
}

output "snapshot_policy_name" {
  description = "The name of the EBS enterprise snapshot policy"
  value       = module.ebs.snapshot_policy_name
}

# Replica Group outputs
output "replica_group_id" {
  description = "The ID of the EBS disk replica group"
  value       = module.ebs.replica_group_id
}

output "replica_group_name" {
  description = "The name of the EBS disk replica group"
  value       = module.ebs.replica_group_name
}

# Solution Instance outputs
output "solution_instance_id" {
  description = "The ID of the EBS solution instance"
  value       = module.ebs.solution_instance_id
}

output "solution_instance_name" {
  description = "The name of the EBS solution instance"
  value       = module.ebs.solution_instance_name
}

output "solution_instance_status" {
  description = "The status of the EBS solution instance"
  value       = module.ebs.solution_instance_status
}

# Local values outputs
output "this_cluster_id" {
  description = "The ID of the EBS cluster (created or external)"
  value       = module.ebs.this_cluster_id
}

output "this_snapshot_policy_id" {
  description = "The ID of the EBS snapshot policy (created or external)"
  value       = module.ebs.this_snapshot_policy_id
}

output "this_replica_group_id" {
  description = "The ID of the EBS replica group (created or external)"
  value       = module.ebs.this_replica_group_id
}