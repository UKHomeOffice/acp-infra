# Create the NAT subnets where the managed NAT gateways live
resource "aws_subnet" "nat_subnets" {
  count             = "${var.nat_gateway ? length(var.zones) : 0}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${var.zones[count.index]}"
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.nat_netmask_offset, count.index + var.nat_subnet_offset)}"

  tags = "${merge(var.tags,
    map("Name", format("nat-%s.%s.%s", var.zones[count.index], var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("Role", "nat-subnets"),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
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
  cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.elb_netmask_offset, count.index + var.elb_subnet_offset)}"

  tags = "${merge(var.tags,
    map("Name", format("elb-%s.%s.%s", var.zones[count.index], var.environment, var.dns_zone)),
    map("Env", var.environment),
    map("Role", "elb-subnets"),
    map("kubernetes.io/role/internal-elb", "true" , "kubernetes.io/role/elb", "1"),
    map("KubernetesCluster", format("%s.%s", var.environment, var.dns_zone)),
    map(format("kubernetes.io/cluster/%s.%s", var.environment, var.dns_zone), "shared"))}"
}

# Associate the ELB subnets with default routing table
resource "aws_route_table_association" "elb_rtas" {
  count          = "${length(var.zones)}"
  subnet_id      = "${element(aws_subnet.elb_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.default.id}"
}
