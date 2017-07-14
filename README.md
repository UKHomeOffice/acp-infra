
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudtrail_bucket | A bucket to push the cloudtrail events to | string | `` | no |
| elb_subnet_offset | The network offset for the ELB subnets | string | `20` | no |
| environment | The unique environment being created e.g. dev, production etc. | string | - | yes |
| nat_gateway | Indicates if you wish to create a NAT gatewaes or not | string | `true` | no |
| nat_subnet_offset | The network offset for the NAT subnets | string | `30` | no |
| network_mask | The network mask used to calculate the ELB and NAT subnets | string | `8` | no |
| tags | A set of tags applied to the vpc being created | string | `<map>` | no |
| vpc_cidr | The CIRDR network block | string | `10.111.0.0/16` | no |
| zones | A collection of availability zones to build in | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| default_rt_id | The ID for the default routing table, with IGW attached |
| elb_cidr | A map containing the availability zone to ELB network CIDR i.e. eu-west-1a -> 10.200.10.0/24 |
| elb_subnets | A map containing the subnet id's for the ELB subnets |
| nat_cidr | A map containing the availability zone to NAT network CIDR i.e. eu-west-1a -> 10.200.10.0/24 |
| nat_gateway_private_ips | A list of the NAT gateway private addresses |
| nat_gateway_public_ips | A list of the NAT gateway EIP public addresses |
| nat_subnets | A map containing the subnet id's for the NAT subnets |
| vpc_id | The ID of the aws vpc which has been created |
| zone_rt_id | A map containing the route table id per availability zone |

