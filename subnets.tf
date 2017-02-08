# Create the subnets required for the base VPN
resource "aws_subnet" "default_subnets" {
  count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index)}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.default_subnet_offset)}"

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-default-az${count.index}"
  }
}

resource "aws_route_table_association" "nat_rtas" {
  count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  subnet_id      = "${element(aws_subnet.default_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}

# The private instance subnets
resource "aws_subnet" "nat_subnets" {
  count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index)}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.nat_subnet_offset)}"

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-nat-az${count.index}"
  }
}

# Route traffic from each instance AZ subnet to each AZ NAT gateway...
resource "aws_route_table_association" "nat_intances" {
  count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  subnet_id      = "${element(aws_subnet.nat_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.az_rts.*.id, count.index)}"
}

resource "aws_subnet" "elb_subnets" {
  count             = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${element(split(",", lookup(var.azs, var.aws_region)), count.index)}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.elb_subnet_offset)}"

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-elb-az${count.index}"
  }
}

resource "aws_route_table_association" "elb_rtas" {
  count          = "${length(split(",", lookup(var.azs, var.aws_region)))}"
  subnet_id      = "${element(aws_subnet.elb_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}