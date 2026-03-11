# Complete Example

This example demonstrates how to use the EBS module to create a complete setup including:

- EBS Dedicated Block Storage Cluster
- Enterprise Snapshot Policy (optional)
- Disk Replica Group (optional)
- EBS Solution Instance (optional)

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs"></a> [ebs](#module\_ebs) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EBS dedicated block storage cluster | `string` | `"example-ebs-cluster"` | no |
| <a name="input_cluster_total_capacity"></a> [cluster\_total\_capacity](#input\_cluster\_total\_capacity) | The total capacity of the EBS dedicated block storage cluster in GiB | `number` | `61440` | no |
| <a name="input_cluster_type"></a> [cluster\_type](#input\_cluster\_type) | The type of the EBS dedicated block storage cluster | `string` | `"Premium"` | no |
| <a name="input_enable_replica_group"></a> [enable\_replica\_group](#input\_enable\_replica\_group) | Whether to create a disk replica group | `bool` | `false` | no |
| <a name="input_enable_snapshot_policy"></a> [enable\_snapshot\_policy](#input\_enable\_snapshot\_policy) | Whether to create an enterprise snapshot policy | `bool` | `true` | no |
| <a name="input_enable_solution_instance"></a> [enable\_solution\_instance](#input\_enable\_solution\_instance) | Whether to create an EBS solution instance | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | The Alicloud region where resources will be created | `string` | `"cn-hangzhou"` | no |
| <a name="input_replica_group_name"></a> [replica\_group\_name](#input\_replica\_group\_name) | The name of the disk replica group | `string` | `"example-replica-group"` | no |
| <a name="input_snapshot_cron_expression"></a> [snapshot\_cron\_expression](#input\_snapshot\_cron\_expression) | The cron expression for the snapshot schedule | `string` | `"0 2 * * *"` | no |
| <a name="input_snapshot_policy_name"></a> [snapshot\_policy\_name](#input\_snapshot\_policy\_name) | The name of the enterprise snapshot policy | `string` | `"example-snapshot-policy"` | no |
| <a name="input_snapshot_retain_days"></a> [snapshot\_retain\_days](#input\_snapshot\_retain\_days) | The number of days to retain snapshots | `string` | `"30"` | no |
| <a name="input_solution_id"></a> [solution\_id](#input\_solution\_id) | The ID of the solution template | `string` | `"mysql"` | no |
| <a name="input_solution_instance_name"></a> [solution\_instance\_name](#input\_solution\_instance\_name) | The name of the EBS solution instance | `string` | `"example-solution-instance"` | no |
| <a name="input_solution_parameters"></a> [solution\_parameters](#input\_solution\_parameters) | The parameters for the solution instance | <pre>list(object({<br>    parameter_key   = string<br>    parameter_value = string<br>  }))</pre> | <pre>[<br>  {<br>    "parameter_key": "zoneId",<br>    "parameter_value": "cn-hangzhou-i"<br>  },<br>  {<br>    "parameter_key": "ecsType",<br>    "parameter_value": "ecs.c6.large"<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources | `map(string)` | <pre>{<br>  "Environment": "example",<br>  "ManagedBy": "Terraform",<br>  "Module": "terraform-alicloud-ebs"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_available_capacity"></a> [cluster\_available\_capacity](#output\_cluster\_available\_capacity) | The available capacity of the EBS dedicated block storage cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EBS dedicated block storage cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EBS dedicated block storage cluster |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The status of the EBS dedicated block storage cluster |
| <a name="output_cluster_used_capacity"></a> [cluster\_used\_capacity](#output\_cluster\_used\_capacity) | The used capacity of the EBS dedicated block storage cluster |
| <a name="output_replica_group_id"></a> [replica\_group\_id](#output\_replica\_group\_id) | The ID of the EBS disk replica group |
| <a name="output_replica_group_name"></a> [replica\_group\_name](#output\_replica\_group\_name) | The name of the EBS disk replica group |
| <a name="output_snapshot_policy_id"></a> [snapshot\_policy\_id](#output\_snapshot\_policy\_id) | The ID of the EBS enterprise snapshot policy |
| <a name="output_snapshot_policy_name"></a> [snapshot\_policy\_name](#output\_snapshot\_policy\_name) | The name of the EBS enterprise snapshot policy |
| <a name="output_solution_instance_id"></a> [solution\_instance\_id](#output\_solution\_instance\_id) | The ID of the EBS solution instance |
| <a name="output_solution_instance_name"></a> [solution\_instance\_name](#output\_solution\_instance\_name) | The name of the EBS solution instance |
| <a name="output_solution_instance_status"></a> [solution\_instance\_status](#output\_solution\_instance\_status) | The status of the EBS solution instance |
| <a name="output_this_cluster_id"></a> [this\_cluster\_id](#output\_this\_cluster\_id) | The ID of the EBS cluster (created or external) |
| <a name="output_this_replica_group_id"></a> [this\_replica\_group\_id](#output\_this\_replica\_group\_id) | The ID of the EBS replica group (created or external) |
| <a name="output_this_snapshot_policy_id"></a> [this\_snapshot\_policy\_id](#output\_this\_snapshot\_policy\_id) | The ID of the EBS snapshot policy (created or external) |

## Configuration Details

### EBS Dedicated Block Storage Cluster

This example creates an EBS dedicated block storage cluster with:
- Premium type cluster (high performance)
- 61440 GiB total capacity
- Deployed in the first available zone

### Enterprise Snapshot Policy

When enabled (`enable_snapshot_policy = true`), this example creates:
- A snapshot policy that runs daily at 2 AM
- Snapshots are retained for 30 days
- Targets disk resources

### Disk Replica Group

When enabled (`enable_replica_group = true`), this example creates:
- A replica group for disaster recovery
- Cross-zone replication within the same region
- RPO of 900 seconds (15 minutes)

### Solution Instance

When enabled (`enable_solution_instance = true`), this example creates:
- An EBS solution instance based on MySQL template
- Configured with basic parameters for demonstration

## Notes

1. Make sure you have sufficient quota for EBS resources in your account
2. The dedicated block storage cluster requires significant resources and may incur costs
3. Some features like replica groups require specific conditions to be met
4. Review and adjust the configuration according to your specific requirements