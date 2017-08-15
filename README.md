
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| allow_teardown | Will enable the teardown of resources for testing environemnt | `false` | no |
| cloudtrail_bucket | A bucket to push the cloudtrail events to | `` | no |
| create_zone | Indicates you want this module to create the hosting domain for you | `true` | no |
| dns_zone | The route53 hosting zone for this cluster | `` | no |
| elb_subnet_offset | The network offset for the ELB subnets | `20` | no |
| environment | The unique environment being created e.g. dev, production etc | - | yes |
| ingress_sg_name | The name of the security group for the ingress nodes | `ingress-additional` | no |
| kops_state_bucket | The name of the state bucket to use for kops | `` | no |
| nat_gateway | Indicates if you wish to create a NAT gatewaes or not | `true` | no |
| nat_subnet_offset | The network offset for the NAT subnets | `30` | no |
| network_mask | The network mask used to calculate the ELB and NAT subnets | `8` | no |
| tags | A set of tags applied to the vpc being created | `<map>` | no |
| terraform_lock_table | The terraform bucket name used for state | - | yes |
| vpc_cidr | The CIRDR network block | `10.111.0.0/16` | no |
| zones | A collection of availability zones to build in | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| default_rt_id |  |
| dns_zone |  |
| dns_zone_id |  |
| elb_cidr |  |
| elb_subnets |  |
| environment |  |
| ingress_sg |  |
| nat_cidr |  |
| nat_gateway_private_ips |  |
| nat_gateway_public_ips |  |
| nat_subnets |  |
| vpc_id |  |
| zone_rt_id |  |

