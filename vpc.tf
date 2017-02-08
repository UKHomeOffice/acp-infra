resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-vpc"
  }
}
