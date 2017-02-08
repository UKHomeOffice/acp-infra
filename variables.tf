variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "The CIRDR network block"
  default     = "10.111.0.0/16"
}

variable "product" {
  default = "keto-infra"
}

variable "environment" {
  description = "The unique environment being created e.g. dev, production etc."
  default     = "test"
}

variable nat_all {
  description = "Enable NAT gateway for the core subnets"
  default     = true
}

# Query AWS to dynamically get the AZ's - unfortunatly this doesn't work...
# ...see https://github.com/hashicorp/terraform/issues/58
# data "aws_availability_zones" "information" {}
variable "azs" {
  description = "The AZ's for a region"
  type        = "map"
  default = {
    "eu-west-1" = "eu-west-1a,eu-west-1b,eu-west-1c"
    "eu-west-2" = "eu-west-2a,eu-west-2b"
  }
}

variable "default_subnet_offset" {
  default = "0"
}

variable "elb_subnet_offset" {
  default = "20"
}

variable "nat_subnet_offset" {
  default = "30"
}
