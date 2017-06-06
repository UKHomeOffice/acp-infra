# Keto-infra

Will create the minimum VPC infrastructure resources required for a typical k8 cluster built using [keto](https://github.com/UKHomeOffice/keto).

The resources currently include:

- VPC
- Gateways
    - Inet (for NAT GW)
    - Nat (one per az)
- Subnets (will create one per az)
    - elbs
    - instances

## Variable Defaults

| Variable | Default Value  |
|----------|----------------|
| `aws_region` | `eu-west-1` |
| `vpc_cidr`   | `10.111.0.0/16` |

See the file [./variables.tf](./variables.tf) for more details.

## Usage

### From CLI

To create a test VPC and infra:
```
$ terraform plan
$ terraform apply
```

### As Module

To create a VPC from a module:
```
module "keto-infra" {
  aws-region  = "eu-west-2"
  environment = "prod"
  source      = "https://github.com/UKHomeOffice/keto-infra"
  vpc_cidr    = "10.200.0.0/16"
}
```
