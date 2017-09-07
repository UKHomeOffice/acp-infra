# Configure all traffic in the public subnets to use the internet gateway
resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}-default-rt"
    KubernetesCluster = "${var.environment}"
  }
}

## Add the default route to internet gateway
resource "aws_route" "default_gateway_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  route_table_id         = "${aws_route_table.default.id}"
}

## Add the route for internet gateway
resource "aws_route" "default_igw" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  route_table_id         = "${aws_route_table.default.id}"
}

## Availability Zone Routing Tables
resource "aws_route_table" "az_rts" {
  count  = "${var.nat_gateway ? length(var.zones) : 0}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}-rt-az${count.index}"
    KubernetesCluster = "${var.environment}"
  }
}

## Add the route for the zone tables
resource "aws_route" "zone_routes" {
  count      = "${var.nat_gateway ? length(var.zones) : 0}"

  depends_on             = ["aws_nat_gateway.nat_gws", "aws_route_table.az_rts" ]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gws.*.id, count.index)}"
  route_table_id         = "${element(aws_route_table.az_rts.*.id, count.index)}"
}
