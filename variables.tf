variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "The CIRDR network block"
  default     = "10.111.0.0/16"
}

variable "environment" {
  description = "The unique environment being created e.g. dev, production etc."
  default     = "test"
}

variable nat_all {
  description = "Enable NAT gateway for the core subnets"
  default     = true
}

data "aws_availability_zones" "available" {}

variable "default_subnet_offset" {
  default = "0"
}

variable "elb_subnet_offset" {
  default = "20"
}

variable "nat_subnet_offset" {
  default = "30"
}
