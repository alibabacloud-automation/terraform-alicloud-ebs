Alicloud EBS (Elastic Block Storage) Terraform Module

# terraform-alicloud-ebs

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/blob/main/README-CN.md)

Terraform module which creates EBS (Elastic Block Storage) resources on Alibaba Cloud. This module provides comprehensive management of EBS dedicated block storage clusters, enterprise snapshot policies, disk replica pairs, replica groups, and solution instances. EBS provides high-performance, reliable, and scalable block storage services for enterprise workloads. 

## Usage

This module allows you to create and manage various EBS resources including dedicated block storage clusters, enterprise snapshot policies, disk replication for disaster recovery, and pre-configured solution instances.

```terraform
module "ebs" {
  source = "alibabacloud-automation/ebs/alicloud"

  # Create EBS dedicated block storage cluster
  create_cluster = true
  cluster_config = {
    name           = "my-ebs-cluster"
    description    = "EBS dedicated block storage cluster"
    total_capacity = 61440
    type           = "Premium"
    zone_id        = "cn-hangzhou-i"
  }

  # Enable enterprise snapshot policy
  create_snapshot_policy = true
  snapshot_policy_config = {
    name        = "my-snapshot-policy"
    description = "Daily snapshot policy"
    target_type = "DISK"
    status      = "ENABLED"
    schedule = {
      cron_expression = "0 2 * * *"
    }
    retain_rule = {
      time_interval = "30"
      time_unit     = "DAYS"
    }
  }

  # Enable disk replica group
  create_replica_group = true
  replica_group_config = {
    name                  = "my-replica-group"
    description           = "Disk replica group for disaster recovery"
    source_region_id      = "cn-hangzhou"
    source_zone_id        = "cn-hangzhou-i"
    destination_region_id = "cn-hangzhou"
    destination_zone_id   = "cn-hangzhou-j"
    rpo                   = 900
    reverse_replicate     = true
  }

  resource_group_id = "rg-acfmxazb4ph6aiy"
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.195.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.195.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ebs_dedicated_block_storage_cluster.cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_dedicated_block_storage_cluster) | resource |
| [alicloud_ebs_disk_replica_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_disk_replica_group) | resource |
| [alicloud_ebs_disk_replica_pair.pair](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_disk_replica_pair) | resource |
| [alicloud_ebs_enterprise_snapshot_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_enterprise_snapshot_policy) | resource |
| [alicloud_ebs_enterprise_snapshot_policy_attachment.attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_enterprise_snapshot_policy_attachment) | resource |
| [alicloud_ebs_replica_group_drill.group_drill](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_replica_group_drill) | resource |
| [alicloud_ebs_replica_pair_drill.pair_drill](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_replica_pair_drill) | resource |
| [alicloud_ebs_solution_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_solution_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | Configuration for the EBS dedicated block storage cluster. Required when create\_cluster is true. The attribute 'zone\_id' cannot be changed after creation. | <pre>object({<br/>    name           = string<br/>    description    = optional(string, null)<br/>    total_capacity = number<br/>    type           = string<br/>    zone_id        = string<br/>  })</pre> | <pre>{<br/>  "name": null,<br/>  "total_capacity": null,<br/>  "type": null,<br/>  "zone_id": null<br/>}</pre> | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of an existing EBS dedicated block storage cluster. Required when create\_cluster is false. | `string` | `null` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Whether to create a new EBS dedicated block storage cluster. If false, an existing cluster ID must be provided. | `bool` | `true` | no |
| <a name="input_create_disk_replica_pair"></a> [create\_disk\_replica\_pair](#input\_create\_disk\_replica\_pair) | Whether to create a new EBS disk replica pair. | `bool` | `true` | no |
| <a name="input_create_replica_group"></a> [create\_replica\_group](#input\_create\_replica\_group) | Whether to create a new EBS disk replica group. | `bool` | `true` | no |
| <a name="input_create_replica_group_drill"></a> [create\_replica\_group\_drill](#input\_create\_replica\_group\_drill) | Whether to create a new EBS replica group drill. | `bool` | `true` | no |
| <a name="input_create_replica_pair_drill"></a> [create\_replica\_pair\_drill](#input\_create\_replica\_pair\_drill) | Whether to create a new EBS replica pair drill. | `bool` | `true` | no |
| <a name="input_create_snapshot_policy"></a> [create\_snapshot\_policy](#input\_create\_snapshot\_policy) | Whether to create a new EBS enterprise snapshot policy. | `bool` | `true` | no |
| <a name="input_create_snapshot_policy_attachment"></a> [create\_snapshot\_policy\_attachment](#input\_create\_snapshot\_policy\_attachment) | Whether to create a new EBS enterprise snapshot policy attachment. | `bool` | `true` | no |
| <a name="input_create_solution_instance"></a> [create\_solution\_instance](#input\_create\_solution\_instance) | Whether to create a new EBS solution instance. | `bool` | `true` | no |
| <a name="input_disk_replica_pair"></a> [disk\_replica\_pair](#input\_disk\_replica\_pair) | Configuration for the disk replica pair to create. The attributes 'destination\_zone\_id', 'source\_zone\_id', 'destination\_region\_id', and 'disk\_id' cannot be changed after creation. | <pre>object({<br/>    name                  = string<br/>    description           = optional(string, null)<br/>    destination_disk_id   = string<br/>    destination_region_id = string<br/>    destination_zone_id   = string<br/>    disk_id               = string<br/>    source_zone_id        = string<br/>    payment_type          = optional(string, "POSTPAY")<br/>    bandwidth             = optional(number, null)<br/>    rpo                   = optional(number, null)<br/>    period                = optional(number, null)<br/>    period_unit           = optional(string, null)<br/>    reverse_replicate     = optional(bool, true)<br/>    one_shot              = optional(bool, false)<br/>    tags = optional(object({<br/>      Environment = optional(string)<br/>      ManagedBy   = optional(string)<br/>      Module      = optional(string)<br/>    }), {})<br/>  })</pre> | `null` | no |
| <a name="input_replica_group_config"></a> [replica\_group\_config](#input\_replica\_group\_config) | Configuration for the EBS disk replica group. Required when create\_replica\_group is true. The attributes 'source\_zone\_id', 'destination\_zone\_id', 'source\_region\_id', and 'destination\_region\_id' cannot be changed after creation. | <pre>object({<br/>    name                  = string<br/>    description           = optional(string, null)<br/>    source_region_id      = string<br/>    source_zone_id        = string<br/>    destination_region_id = string<br/>    destination_zone_id   = string<br/>    rpo                   = optional(number, 900)<br/>    reverse_replicate     = optional(bool, true)<br/>    one_shot              = optional(bool, false)<br/>    pair_ids              = optional(list(string), [])<br/>    tags = optional(object({<br/>      Environment = optional(string)<br/>      ManagedBy   = optional(string)<br/>      Module      = optional(string)<br/>    }), {})<br/>  })</pre> | <pre>{<br/>  "destination_region_id": null,<br/>  "destination_zone_id": null,<br/>  "name": null,<br/>  "source_region_id": null,<br/>  "source_zone_id": null<br/>}</pre> | no |
| <a name="input_replica_group_id"></a> [replica\_group\_id](#input\_replica\_group\_id) | The ID of an existing EBS disk replica group. Required when create\_replica\_group\_drill is true and create\_replica\_group is false. | `string` | `null` | no |
| <a name="input_replica_pair_drill"></a> [replica\_pair\_drill](#input\_replica\_pair\_drill) | Configuration for the replica pair drill to create. | <pre>object({<br/>    pair_id = string<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the resource group where the EBS resources will be created. | `string` | `null` | no |
| <a name="input_snapshot_policy_attachment"></a> [snapshot\_policy\_attachment](#input\_snapshot\_policy\_attachment) | Configuration for the snapshot policy attachment to create. | <pre>object({<br/>    disk_id = string<br/>  })</pre> | `null` | no |
| <a name="input_snapshot_policy_config"></a> [snapshot\_policy\_config](#input\_snapshot\_policy\_config) | Configuration for the EBS enterprise snapshot policy. Required when create\_snapshot\_policy is true. | <pre>object({<br/>    name        = string<br/>    description = optional(string, null)<br/>    target_type = string<br/>    status      = optional(string, "ENABLED")<br/>    tags = optional(object({<br/>      Environment = optional(string)<br/>      ManagedBy   = optional(string)<br/>      Module      = optional(string)<br/>    }), {})<br/>    schedule = object({<br/>      cron_expression = string<br/>    })<br/>    retain_rule = object({<br/>      number        = optional(number, null)<br/>      time_interval = optional(string, null)<br/>      time_unit     = optional(string, null)<br/>    })<br/>    cross_region_copy_info = optional(object({<br/>      enabled = optional(bool, false)<br/>      regions = optional(list(object({<br/>        region_id   = string<br/>        retain_days = number<br/>      })), [])<br/>    }), null)<br/>    special_retain_rules = optional(object({<br/>      enabled = optional(bool, false)<br/>      rules = optional(list(object({<br/>        special_period_unit = string<br/>        time_interval       = number<br/>        time_unit           = string<br/>      })), [])<br/>    }), null)<br/>    storage_rule = optional(object({<br/>      enable_immediate_access = optional(bool, false)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "name": null,<br/>  "retain_rule": {},<br/>  "schedule": {<br/>    "cron_expression": null<br/>  },<br/>  "target_type": null<br/>}</pre> | no |
| <a name="input_snapshot_policy_id"></a> [snapshot\_policy\_id](#input\_snapshot\_policy\_id) | The ID of an existing EBS enterprise snapshot policy. Required when creating snapshot policy attachments and create\_snapshot\_policy is false. | `string` | `null` | no |
| <a name="input_solution_instance_config"></a> [solution\_instance\_config](#input\_solution\_instance\_config) | Configuration for the EBS solution instance. Required when create\_solution\_instance is true. | <pre>object({<br/>    name        = string<br/>    solution_id = string<br/>    description = optional(string, null)<br/>    parameters = optional(list(object({<br/>      parameter_key   = string<br/>      parameter_value = string<br/>    })), [])<br/>  })</pre> | <pre>{<br/>  "name": null,<br/>  "solution_id": null<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_available_capacity"></a> [cluster\_available\_capacity](#output\_cluster\_available\_capacity) | The available capacity of the EBS dedicated block storage cluster in GiB |
| <a name="output_cluster_create_time"></a> [cluster\_create\_time](#output\_cluster\_create\_time) | The creation time of the EBS dedicated block storage cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EBS dedicated block storage cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EBS dedicated block storage cluster |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The status of the EBS dedicated block storage cluster |
| <a name="output_cluster_used_capacity"></a> [cluster\_used\_capacity](#output\_cluster\_used\_capacity) | The used capacity of the EBS dedicated block storage cluster in GiB |
| <a name="output_disk_replica_pair_create_time"></a> [disk\_replica\_pair\_create\_time](#output\_disk\_replica\_pair\_create\_time) | The creation time of the EBS disk replica pair |
| <a name="output_disk_replica_pair_id"></a> [disk\_replica\_pair\_id](#output\_disk\_replica\_pair\_id) | The ID of the EBS disk replica pair |
| <a name="output_disk_replica_pair_name"></a> [disk\_replica\_pair\_name](#output\_disk\_replica\_pair\_name) | The name of the EBS disk replica pair |
| <a name="output_disk_replica_pair_status"></a> [disk\_replica\_pair\_status](#output\_disk\_replica\_pair\_status) | The status of the EBS disk replica pair |
| <a name="output_replica_group_drill_id"></a> [replica\_group\_drill\_id](#output\_replica\_group\_drill\_id) | The ID of the EBS replica group drill |
| <a name="output_replica_group_drill_status"></a> [replica\_group\_drill\_status](#output\_replica\_group\_drill\_status) | The status of the EBS replica group drill |
| <a name="output_replica_group_id"></a> [replica\_group\_id](#output\_replica\_group\_id) | The ID of the EBS disk replica group |
| <a name="output_replica_group_name"></a> [replica\_group\_name](#output\_replica\_group\_name) | The name of the EBS disk replica group |
| <a name="output_replica_pair_drill_id"></a> [replica\_pair\_drill\_id](#output\_replica\_pair\_drill\_id) | The ID of the EBS replica pair drill |
| <a name="output_replica_pair_drill_status"></a> [replica\_pair\_drill\_status](#output\_replica\_pair\_drill\_status) | The status of the EBS replica pair drill |
| <a name="output_snapshot_policy_attachment_id"></a> [snapshot\_policy\_attachment\_id](#output\_snapshot\_policy\_attachment\_id) | The ID of the EBS enterprise snapshot policy attachment |
| <a name="output_snapshot_policy_create_time"></a> [snapshot\_policy\_create\_time](#output\_snapshot\_policy\_create\_time) | The creation time of the EBS enterprise snapshot policy |
| <a name="output_snapshot_policy_id"></a> [snapshot\_policy\_id](#output\_snapshot\_policy\_id) | The ID of the EBS enterprise snapshot policy |
| <a name="output_snapshot_policy_name"></a> [snapshot\_policy\_name](#output\_snapshot\_policy\_name) | The name of the EBS enterprise snapshot policy |
| <a name="output_solution_instance_create_time"></a> [solution\_instance\_create\_time](#output\_solution\_instance\_create\_time) | The creation time of the EBS solution instance |
| <a name="output_solution_instance_id"></a> [solution\_instance\_id](#output\_solution\_instance\_id) | The ID of the EBS solution instance |
| <a name="output_solution_instance_name"></a> [solution\_instance\_name](#output\_solution\_instance\_name) | The name of the EBS solution instance |
| <a name="output_solution_instance_status"></a> [solution\_instance\_status](#output\_solution\_instance\_status) | The status of the EBS solution instance |
| <a name="output_this_cluster_id"></a> [this\_cluster\_id](#output\_this\_cluster\_id) | The ID of the EBS cluster (created or external) |
| <a name="output_this_replica_group_id"></a> [this\_replica\_group\_id](#output\_this\_replica\_group\_id) | The ID of the EBS replica group (created or external) |
| <a name="output_this_snapshot_policy_id"></a> [this\_snapshot\_policy\_id](#output\_this\_snapshot\_policy\_id) | The ID of the EBS snapshot policy (created or external) |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)