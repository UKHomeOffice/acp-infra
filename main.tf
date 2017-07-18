
# Provider will inherit from environment variables
provider "aws" {}

## Create the hosting zone for the cluster
resource "aws_route53_zone" "zone" {
  name = "${var.dns_zone}"

  tags = "${merge(var.tags, map("Name", var.environment), map("Env", var.environment), map("KubernetesCluster", var.environment))}"
}

# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${merge(var.tags, map("Name", var.environment), map("Env", var.environment), map("KubernetesCluster", var.environment))}"
}
