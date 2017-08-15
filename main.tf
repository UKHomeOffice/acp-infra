# Provider will inherit from environment variables
provider "aws" {
  version = "= 0.1.4"
}

## Create the hosting zone for the cluster
resource "aws_route53_zone" "zone" {
  count = "${var.create_zone ? 1 : 0}"

  name = "${var.dns_zone}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
}

# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
}
