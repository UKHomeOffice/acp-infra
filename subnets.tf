# Create the subnets required for the base VPN
resource "aws_subnet" "default_subnets" {
  count             = "${length(data.aws_availability_zones.available.names)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.default_subnet_offset)}"

  tags {
    Env               = "${var.environment}"
    Role              = "default-subnets"
    Name              = "${var.environment}--default-az${count.index}"
    KubernetesCluster = "${var.environment}"
  }
}

resource "aws_route_table_association" "nat_rtas" {
  count          = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.default_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}

# The private instance subnets
resource "aws_subnet" "nat_subnets" {
  count             = "${length(data.aws_availability_zones.available.names)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.nat_subnet_offset)}"

  tags {
    Env               = "${var.environment}"
    Role              = "nat-subnets"
    Name              = "${var.environment}-nat-az${count.index}"
    KubernetesCluster = "${var.environment}"
  }
}

# Route traffic from each instance AZ subnet to each AZ NAT gateway...
resource "aws_route_table_association" "nat_intances" {
  count          = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.nat_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.az_rts.*.id, count.index)}"
}

resource "aws_subnet" "elb_subnets" {
  count             = "${length(data.aws_availability_zones.available.names)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.elb_subnet_offset)}"

  tags {
    Env                               = "${var.environment}"
    Role                              = "elb-subnets"
    Name                              = "${var.environment}-elb-az${count.index}"
    KubernetesCluster                 = "${var.environment}"
    "kubernetes.io/role/internal-elb" = "true"
    "kubernetes.io/role/elb"          = "true"
  }
}

resource "aws_route_table_association" "elb_rtas" {
  count          = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.elb_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}
