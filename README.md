<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_eip.nat_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_nat_gateway.nat_gws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.default_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.zone_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route_table.az_rts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.elb_rtas](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.nat_intances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress_all_allow_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_node_ports_32000](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.elb_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.nat_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_teardown"></a> [allow\_teardown](#input\_allow\_teardown) | Will enable the teardown of resources for testing environemnt | `bool` | `false` | no |
| <a name="input_cloudtrail_bucket"></a> [cloudtrail\_bucket](#input\_cloudtrail\_bucket) | A bucket to push the cloudtrail events to | `string` | `""` | no |
| <a name="input_create_kms"></a> [create\_kms](#input\_create\_kms) | Indicates you wish to enable a managed kms key for this cluster | `bool` | `false` | no |
| <a name="input_create_zone"></a> [create\_zone](#input\_create\_zone) | Indicates you want this module to create the hosting domain for you | `bool` | `true` | no |
| <a name="input_create_zone_rt"></a> [create\_zone\_rt](#input\_create\_zone\_rt) | Indicates if you wish to create a route table for the AZs (should be true if nat\_gateway is true) | `bool` | `true` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | The route53 hosting zone for this cluster | `string` | `""` | no |
| <a name="input_elb_netmask_offset"></a> [elb\_netmask\_offset](#input\_elb\_netmask\_offset) | The network mask used to calculate the ELB subnets | `number` | `8` | no |
| <a name="input_elb_subnet_offset"></a> [elb\_subnet\_offset](#input\_elb\_subnet\_offset) | The network offset for the ELB subnets | `string` | `"20"` | no |
| <a name="input_enable_kms_rotation"></a> [enable\_kms\_rotation](#input\_enable\_kms\_rotation) | If create\_kms is enabled you can control key rotation from here | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The unique environment being created e.g. dev, production etc | `any` | n/a | yes |
| <a name="input_ingress_sg_name"></a> [ingress\_sg\_name](#input\_ingress\_sg\_name) | The name of the security group for the ingress nodes | `string` | `"ingress-additional"` | no |
| <a name="input_kms_deletion_window"></a> [kms\_deletion\_window](#input\_kms\_deletion\_window) | The number of days for the KMS will stay post deletion | `string` | `"30"` | no |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | Indicates if you wish to create a NAT gateways or not | `bool` | `true` | no |
| <a name="input_nat_netmask_offset"></a> [nat\_netmask\_offset](#input\_nat\_netmask\_offset) | The network mask used to calculate the NAT subnets | `number` | `8` | no |
| <a name="input_nat_subnet_offset"></a> [nat\_subnet\_offset](#input\_nat\_subnet\_offset) | The network offset for the NAT subnets | `string` | `"30"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags applied to the vpc being created | `map(string)` | `{}` | no |
| <a name="input_terraform_lock_table"></a> [terraform\_lock\_table](#input\_terraform\_lock\_table) | The terraform bucket name used for state | `string` | `""` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIRDR network block | `string` | `"10.111.0.0/16"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A collection of availability zones to build in | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_rt_id"></a> [default\_rt\_id](#output\_default\_rt\_id) | The ID for the default routing table, with IGW attached |
| <a name="output_dns_zone"></a> [dns\_zone](#output\_dns\_zone) | The DNS for this cluster |
| <a name="output_dns_zone_id"></a> [dns\_zone\_id](#output\_dns\_zone\_id) | The route53 zone id for the cluster |
| <a name="output_elb_cidr"></a> [elb\_cidr](#output\_elb\_cidr) | A map containing the availability zone to ELB network CIDR i.e. eu-west-1a -> 10.200.10.0/24 |
| <a name="output_elb_subnets"></a> [elb\_subnets](#output\_elb\_subnets) | A map containing the subnet id's for the ELB subnets |
| <a name="output_environment"></a> [environment](#output\_environment) | The environment name for this cluster |
| <a name="output_ingress_sg"></a> [ingress\_sg](#output\_ingress\_sg) | The default security group created for the ingress nodes |
| <a name="output_kms_id"></a> [kms\_id](#output\_kms\_id) | If enabled this is the ID of the managed KMS key for the cluster |
| <a name="output_nat_cidr"></a> [nat\_cidr](#output\_nat\_cidr) | A map containing the availability zone to NAT network CIDR i.e. eu-west-1a -> 10.200.10.0/24 |
| <a name="output_nat_gateway_private_ips"></a> [nat\_gateway\_private\_ips](#output\_nat\_gateway\_private\_ips) | A list of the NAT gateway private addresses |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | A list of the NAT gateway EIP public addresses |
| <a name="output_nat_subnets"></a> [nat\_subnets](#output\_nat\_subnets) | A map containing the subnet id's for the NAT subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the aws vpc which has been created |
| <a name="output_zone_rt_id"></a> [zone\_rt\_id](#output\_zone\_rt\_id) | A map containing the route table id per availability zone |
<!-- END_TF_DOCS -->