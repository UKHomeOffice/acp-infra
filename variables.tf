variable "allow_teardown" {
  description = "Will enable the teardown of resources for testing environemnt"
  default     = false
}

variable "vpc_cidr" {
  description = "The CIRDR network block"
  default     = "10.111.0.0/16"
}

variable "environment" {
  description = "The unique environment being created e.g. dev, production etc"
}

variable "dns_zone" {
  description = "The route53 hosting zone for this cluster"
  default     = ""
}

variable "tags" {
  description = "A set of tags applied to the vpc being created"
  default     = {}
}

variable "nat_gateway" {
  description = "Indicates if you wish to create a NAT gatewaes or not"
  default     = true
}

variable "zones" {
  description = "A collection of availability zones to build in"
  type        = "list"
}

variable "create_zone" {
  description = "Indicates you want this module to create the hosting domain for you"
  default     = true
}

variable "cloudtrail_bucket" {
  description = "A bucket to push the cloudtrail events to"
  default     = ""
}

variable "network_mask" {
  description = "The network mask used to calculate the ELB and NAT subnets"
  default     = 8
}

variable "elb_subnet_offset" {
  description = "The network offset for the ELB subnets"
  default     = "20"
}

variable "nat_subnet_offset" {
  description = "The network offset for the NAT subnets"
  default     = "30"
}

variable "ingress_sg_name" {
  description = "The name of the security group for the ingress nodes"
  default     = "ingress-additional"
}

variable "kops_state_bucket" {
  description = "The name of the state bucket to use for kops"
  default     = ""
}

variable "terraform_lock_table" {
  description = "The terraform bucket name used for state"
  default     = ""
}
