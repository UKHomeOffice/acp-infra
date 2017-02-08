resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-main"
  }
}

resource "aws_eip" "nat_ips" {
  count  = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  vpc    = true
}

resource "aws_nat_gateway" "nat_gws" {
  depends_on    = ["aws_internet_gateway.main", "aws_subnet.default_subnets"]

  count         = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  allocation_id = "${element(aws_eip.nat_ips.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.default_subnets.*.id, count.index)}"
}
