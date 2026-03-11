variable "region" {
  description = "The Alicloud region where resources will be created"
  type        = string
  default     = "cn-hangzhou"
}

variable "name" {
  description = "The name prefix for disk"
  type        = string
  default     = "tf-example"
}

variable "create_cluster" {
  description = "Whether to create the EBS dedicated block storage cluster (requires valid capacity and zone that supports EBS clusters)"
  type        = bool
  default     = false
}

variable "enable_snapshot_policy" {
  description = "Whether to create an enterprise snapshot policy"
  type        = bool
  default     = true
}

variable "snapshot_policy_name" {
  description = "The name of the enterprise snapshot policy"
  type        = string
  default     = "example-snapshot-policy"
}

variable "snapshot_cron_expression" {
  description = "The cron expression for the snapshot schedule"
  type        = string
  default     = "0 0 2 * * ?"
}

variable "snapshot_retain_days" {
  description = "The number of days to retain snapshots"
  type        = number
  default     = 30
}

variable "snapshot_retain_number" {
  description = "The number of snapshots to retain"
  type        = number
  default     = 10
}

variable "enable_replica_group" {
  description = "Whether to create a disk replica group"
  type        = bool
  default     = true
}

variable "replica_group_name" {
  description = "The name of the disk replica group"
  type        = string
  default     = "example-replica-group"
}

variable "enable_solution_instance" {
  description = "Whether to create an EBS solution instance"
  type        = bool
  default     = true
}

variable "solution_instance_name" {
  description = "The name of the EBS solution instance"
  type        = string
  default     = "example-solution-instance"
}

variable "solution_id" {
  description = "The ID of the solution template"
  type        = string
  default     = "" # 需要在实际使用时提供有效的解决方案ID
}

variable "solution_parameters" {
  description = "The parameters for the solution instance"
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  default = [
    {
      parameter_key   = "zoneId"
      parameter_value = "cn-hangzhou-i"
    },
    {
      parameter_key   = "ecsType"
      parameter_value = "ecs.c6.large"
    }
  ]
}

variable "enable_snapshot_policy_attachment" {
  description = "Whether to create a snapshot policy attachment"
  type        = bool
  default     = true
}

variable "snapshot_policy_attachment_disk_id" {
  description = "The disk ID for the snapshot policy attachment"
  type        = string
  default     = "" # 需要在实际使用时提供有效的磁盘ID
}

variable "enable_disk_replica_pair" {
  description = "Whether to create a disk replica pair"
  type        = bool
  default     = true
}

variable "disk_replica_pair_name" {
  description = "The name of the disk replica pair"
  type        = string
  default     = "example-disk-replica-pair"
}

variable "disk_replica_pair_description" {
  description = "The description of the disk replica pair"
  type        = string
  default     = "Disk replica pair created by Terraform"
}

variable "disk_replica_pair_source_disk_id" {
  description = "The source disk ID for the replica pair"
  type        = string
  default     = "" # 需要在实际使用时提供有效的磁盘ID
}

variable "disk_replica_pair_destination_disk_id" {
  description = "The destination disk ID for the replica pair"
  type        = string
  default     = "" # 需要在实际使用时提供有效的磁盘ID
}

variable "disk_replica_pair_payment_type" {
  description = "The payment type for the replica pair"
  type        = string
  default     = "POSTPAY"
}

variable "disk_replica_pair_bandwidth" {
  description = "The bandwidth for the replica pair (must be one of 0, 10240, 20480, 51200, 102400)"
  type        = number
  default     = 10240
}

variable "disk_replica_pair_rpo" {
  description = "The RPO (Recovery Point Objective) for the replica pair"
  type        = number
  default     = 900
}

variable "tags" {
  description = "An object of tags to assign to the resources"
  type = object({
    Environment = string
    ManagedBy   = string
    Module      = string
  })
  default = {
    Environment = "example"
    ManagedBy   = "Terraform"
    Module      = "terraform-alicloud-ebs"
  }
}