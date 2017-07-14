variable "vpc_cidr" {
  description = "The CIRDR network block"
  default     = "10.111.0.0/16"
}

variable "environment" {
  description = "The unique environment being created e.g. dev, production etc."
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
