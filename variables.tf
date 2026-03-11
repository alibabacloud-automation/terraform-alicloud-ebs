# Resource creation control variables
variable "create_cluster" {
  description = "Whether to create a new EBS dedicated block storage cluster. If false, an existing cluster ID must be provided."
  type        = bool
  default     = true
}

variable "create_snapshot_policy" {
  description = "Whether to create a new EBS enterprise snapshot policy."
  type        = bool
  default     = true
}

variable "create_replica_group" {
  description = "Whether to create a new EBS disk replica group."
  type        = bool
  default     = true
}

variable "create_replica_group_drill" {
  description = "Whether to create a new EBS replica group drill."
  type        = bool
  default     = true
}

variable "create_solution_instance" {
  description = "Whether to create a new EBS solution instance."
  type        = bool
  default     = true
}

variable "create_snapshot_policy_attachment" {
  description = "Whether to create a new EBS enterprise snapshot policy attachment."
  type        = bool
  default     = true
}

variable "create_disk_replica_pair" {
  description = "Whether to create a new EBS disk replica pair."
  type        = bool
  default     = true
}

variable "create_replica_pair_drill" {
  description = "Whether to create a new EBS replica pair drill."
  type        = bool
  default     = true
}

# External resource ID variables (used when create_* = false)
variable "cluster_id" {
  description = "The ID of an existing EBS dedicated block storage cluster. Required when create_cluster is false."
  type        = string
  default     = null
}

variable "snapshot_policy_id" {
  description = "The ID of an existing EBS enterprise snapshot policy. Required when creating snapshot policy attachments and create_snapshot_policy is false."
  type        = string
  default     = null
}

variable "replica_group_id" {
  description = "The ID of an existing EBS disk replica group. Required when create_replica_group_drill is true and create_replica_group is false."
  type        = string
  default     = null
}

# Common variables
variable "resource_group_id" {
  description = "The ID of the resource group where the EBS resources will be created."
  type        = string
  default     = null
}

# Cluster configuration
variable "cluster_config" {
  description = "Configuration for the EBS dedicated block storage cluster. Required when create_cluster is true. The attribute 'zone_id' cannot be changed after creation."
  type = object({
    name           = string
    description    = optional(string, null)
    total_capacity = number
    type           = string
    zone_id        = string
  })
  default = {
    name           = null
    total_capacity = null
    type           = null
    zone_id        = null
  }
}

# Snapshot policy configuration
variable "snapshot_policy_config" {
  description = "Configuration for the EBS enterprise snapshot policy. Required when create_snapshot_policy is true."
  type = object({
    name        = string
    description = optional(string, null)
    target_type = string
    status      = optional(string, "ENABLED")
    tags = optional(object({
      Environment = optional(string)
      ManagedBy   = optional(string)
      Module      = optional(string)
    }), {})
    schedule = object({
      cron_expression = string
    })
    retain_rule = object({
      number        = optional(number, null)
      time_interval = optional(string, null)
      time_unit     = optional(string, null)
    })
    cross_region_copy_info = optional(object({
      enabled = optional(bool, false)
      regions = optional(list(object({
        region_id   = string
        retain_days = number
      })), [])
    }), null)
    special_retain_rules = optional(object({
      enabled = optional(bool, false)
      rules = optional(list(object({
        special_period_unit = string
        time_interval       = number
        time_unit           = string
      })), [])
    }), null)
    storage_rule = optional(object({
      enable_immediate_access = optional(bool, false)
    }), null)
  })
  default = {
    name        = null
    target_type = null
    schedule = {
      cron_expression = null
    }
    retain_rule = {}
  }
}

# Snapshot policy attachment
variable "snapshot_policy_attachment" {
  description = "Configuration for the snapshot policy attachment to create."
  type = object({
    disk_id = string
  })
  default = null
}

# Disk replica pair
variable "disk_replica_pair" {
  description = "Configuration for the disk replica pair to create. The attributes 'destination_zone_id', 'source_zone_id', 'destination_region_id', and 'disk_id' cannot be changed after creation."
  type = object({
    name                  = string
    description           = optional(string, null)
    destination_disk_id   = string
    destination_region_id = string
    destination_zone_id   = string
    disk_id               = string
    source_zone_id        = string
    payment_type          = optional(string, "POSTPAY")
    bandwidth             = optional(number, null)
    rpo                   = optional(number, null)
    period                = optional(number, null)
    period_unit           = optional(string, null)
    reverse_replicate     = optional(bool, true)
    one_shot              = optional(bool, false)
    tags = optional(object({
      Environment = optional(string)
      ManagedBy   = optional(string)
      Module      = optional(string)
    }), {})
  })
  default = null
}

# Replica group configuration
variable "replica_group_config" {
  description = "Configuration for the EBS disk replica group. Required when create_replica_group is true. The attributes 'source_zone_id', 'destination_zone_id', 'source_region_id', and 'destination_region_id' cannot be changed after creation."
  type = object({
    name                  = string
    description           = optional(string, null)
    source_region_id      = string
    source_zone_id        = string
    destination_region_id = string
    destination_zone_id   = string
    rpo                   = optional(number, 900)
    reverse_replicate     = optional(bool, true)
    one_shot              = optional(bool, false)
    pair_ids              = optional(list(string), [])
    tags = optional(object({
      Environment = optional(string)
      ManagedBy   = optional(string)
      Module      = optional(string)
    }), {})
  })
  default = {
    name                  = null
    source_region_id      = null
    source_zone_id        = null
    destination_region_id = null
    destination_zone_id   = null
  }
}

# Replica pair drill
variable "replica_pair_drill" {
  description = "Configuration for the replica pair drill to create."
  type = object({
    pair_id = string
  })
  default = null
}

# Solution instance configuration
variable "solution_instance_config" {
  description = "Configuration for the EBS solution instance. Required when create_solution_instance is true."
  type = object({
    name        = string
    solution_id = string
    description = optional(string, null)
    parameters = optional(list(object({
      parameter_key   = string
      parameter_value = string
    })), [])
  })
  default = {
    name        = null
    solution_id = null
  }
}