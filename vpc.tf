resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}-vpc"
    KubernetesCluster = "${var.environment}"
  }

}
