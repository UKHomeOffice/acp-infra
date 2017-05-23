# Module to create a VPC and networking items to work with Kubernetes infrastructures
# Input data provided by varaiables to specify both regions and number of node groups


provider "aws" {
  region = "${var.aws_region}"
}
