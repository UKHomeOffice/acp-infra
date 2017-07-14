variable "vpc_cidr" {
  description = "The CIRDR network block"
  default     = "10.111.0.0/16"
}

variable "environment" {
  description = "The unique environment being created e.g. dev, production etc."
}

variable "zones" {
  description = "A collection of availability zones to build in"
  type        = "list"
}

variable "cloudtrail_bucket" {
  description = "A bucket to push the cloudtrail events to"
  default     = ""
}

variable "elb_subnet_offset" {
  default = "20"
}

variable "nat_subnet_offset" {
  default = "30"
}
