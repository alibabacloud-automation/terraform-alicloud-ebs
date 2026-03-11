Alicloud EBS (Elastic Block Storage) Terraform Module

# terraform-alicloud-ebs

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/blob/main/README-CN.md)

Terraform module which creates EBS (Elastic Block Storage) resources on Alibaba Cloud. This module provides comprehensive management of EBS dedicated block storage clusters, enterprise snapshot policies, disk replica pairs, replica groups, and solution instances. EBS provides high-performance, reliable, and scalable block storage services for enterprise workloads. For more information about EBS capabilities and features, see [Elastic Block Storage](https://www.alibabacloud.com/product/ebs).

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

  resource_group_id = "rg-acfmxazb4ph6aiy"
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
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