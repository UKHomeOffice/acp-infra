# Create the NAT subnets where the managed NAT gateways live
resource "aws_subnet" "nat_subnets" {
  count             = "${var.nat_gateway ? length(var.zones) : 0}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${var.zones[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.network_mask, count.index + var.nat_subnet_offset)}"

  tags {
    Env               = "${var.environment}"
    Role              = "nat-subnets"
    Name              = "${var.environment}-nat-az${count.index}"
    KubernetesCluster = "${var.environment}"
  }
}

# Associate the NAT subnets with the default routing table
resource "aws_route_table_association" "nat_intances" {
  count          = "${var.nat_gateway ? length(var.zones) : 0}"
  subnet_id      = "${element(aws_subnet.nat_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}

# Create the ELB subnets
resource "aws_subnet" "elb_subnets" {
  count             = "${length(var.zones)}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${var.zones[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.network_mask, count.index + var.elb_subnet_offset)}"

  tags {
    Env                               = "${var.environment}"
    Role                              = "elb-subnets"
    Name                              = "${var.environment}-elb-az${count.index}"
    KubernetesCluster                 = "${var.environment}"
    "kubernetes.io/role/internal-elb" = "true"
    "kubernetes.io/role/elb"          = "true"
  }
}

# Associate the ELB subnets with default routing table
resource "aws_route_table_association" "elb_rtas" {
  count          = "${length(var.zones)}"
  subnet_id      = "${element(aws_subnet.elb_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}
