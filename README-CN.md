阿里云 EBS (弹性块存储) Terraform 模块

# terraform-alicloud-ebs

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/blob/main/README.md) | 简体中文

用于在阿里云上创建 EBS（弹性块存储）资源的 Terraform 模块。该模块提供 EBS 专属块存储集群、企业级快照策略、磁盘复制对、复制组和解决方案实例的全面管理。EBS 为企业工作负载提供高性能、可靠且可扩展的块存储服务。有关 EBS 功能和特性的更多信息，请参阅[弹性块存储](https://www.alibabacloud.com/product/ebs)。

## 使用方法

该模块允许您创建和管理各种 EBS 资源，包括专属块存储集群、企业级快照策略、用于灾难恢复的磁盘复制和预配置的解决方案实例。

```terraform
module "ebs" {
  source = "alibabacloud-automation/ebs/alicloud"

  # 创建 EBS 专属块存储集群
  create_cluster = true
  cluster_config = {
    name           = "my-ebs-cluster"
    description    = "EBS 专属块存储集群"
    total_capacity = 61440
    type           = "Premium"
    zone_id        = "cn-hangzhou-i"
  }

  # 启用企业级快照策略
  create_snapshot_policy = true
  snapshot_policy_config = {
    name        = "my-snapshot-policy"
    description = "每日快照策略"
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ebs/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)