
# Provider will inherit from environment variables
provider "aws" {}

# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${merge(var.tags, map("Name", format("%s", var.environment)), map("Env", format("%s", var.environment)), map("KubernetesCluster", format("%s", var.environment)))}"
}
