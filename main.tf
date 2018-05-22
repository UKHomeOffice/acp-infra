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

## Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
}

## Create a KMS key for this environment
resource "aws_kms_key" "kms" {
  count = "${var.create_kms ? 1 : 0}"

  deletion_window_in_days = "${var.kms_deletion_window}"
  description             = "The managed KMS for cluster: ${var.environment}.${var.dns_zone}"
  enable_key_rotation     = "${var.enable_kms_rotation}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
}

## Create the KMS Alias for the above key
resource "aws_kms_alias" "alias" {
  count = "${var.create_kms ? 1 : 0}"

  name          = "alias/${var.environment}"
  target_key_id = "${aws_kms_key.kms.key_id}"
}
