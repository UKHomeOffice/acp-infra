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
  description = "Indicates if you wish to create a NAT gateways or not"
  default     = true
}

variable "create_zone_rt" {
  description = "Indicates if you wish to create a route table for the AZs (should be true if nat_gateway is true)"
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

variable "create_kms" {
  description = "Indicates you wish to enable a managed kms key for this cluster"
  default     = false
}

variable "enable_kms_rotation" {
  description = "If create_kms is enabled you can control key rotation from here"
  default     = false
}

variable "kms_deletion_window" {
  description = "The number of days for the KMS will stay post deletion"
  default     = "30"
}

variable "cloudtrail_bucket" {
  description = "A bucket to push the cloudtrail events to"
  default     = ""
}

variable "elb_netmask_offset" {
  description = "The network mask used to calculate the ELB subnets"
  default     = 8
}

variable "nat_netmask_offset" {
  description = "The network mask used to calculate the NAT subnets"
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

variable "terraform_lock_table" {
  description = "The terraform bucket name used for state"
  default     = ""
}
