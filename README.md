
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| allow_teardown | Will enable the teardown of resources for testing environemnt | `false` | no |
| cloudtrail_bucket | A bucket to push the cloudtrail events to | `` | no |
| create_kms | Indicates you wish to enable a managed kms key for this cluster | `false` | no |
| create_zone | Indicates you want this module to create the hosting domain for you | `true` | no |
| dns_zone | The route53 hosting zone for this cluster | `` | no |
| elb_netmask_offset | The network mask used to calculate the ELB subnets | `4` | no |
| elb_subnet_offset | The network offset for the ELB subnets | `2` | no |
| enable_kms_rotation | If create_kms is enabled you can control key rotation from here | `false` | no |
| environment | The unique environment being created e.g. dev, production etc | - | yes |
| ingress_sg_name | The name of the security group for the ingress nodes | `ingress-additional` | no |
| kms_deletion_window | The number of days for the KMS will stay post deletion | `30` | no |
| kops_state_bucket | The name of the state bucket to use for kops | `` | no |
| nat_gateway | Indicates if you wish to create a NAT gatewaes or not | `true` | no |
| nat_netmask_offset | The network mask used to calculate the NAT subnets | `5` | no |
| nat_subnet_offset | The network offset for the NAT subnets | `0` | no |
| ownership | The kubernetes ownership tag on the aws resources i.e. shared or owned | `shared` | no |
| tags | A set of tags applied to the vpc being created | `<map>` | no |
| terraform_lock_table | The terraform bucket name used for state | `` | no |
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
| kms_id |  |
| nat_cidr |  |
| nat_gateway_private_ips |  |
| nat_gateway_public_ips |  |
| nat_subnets |  |
| vpc_id |  |
| zone_rt_id |  |

