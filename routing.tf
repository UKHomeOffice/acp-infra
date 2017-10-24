# Configure all traffic in the public subnets to use the internet gateway
resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}.${var.dns_zone}"
    KubernetesCluster = "${var.environment}.${var.dns_zone}"
  }
}

## Add the default route to internet gateway
resource "aws_route" "default_gateway_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  route_table_id         = "${aws_route_table.default.id}"
}

## Availability Zone Routing Tables
resource "aws_route_table" "az_rts" {
  count  = "${var.create_zone_rt ? length(var.zones) : 0}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Env               = "${var.environment}"
    Name              = "private-${element(var.zones, count.index)}.${var.environment}.${var.dns_zone}"
    KubernetesCluster = "${var.environment}.${var.dns_zone}"
  }
}

## Add the route for the zone tables
resource "aws_route" "zone_routes" {
  count      = "${var.nat_gateway ? length(var.zones) : 0}"
  depends_on = ["aws_route_table.az_rts"]

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gws.*.id, count.index)}"
  route_table_id         = "${element(aws_route_table.az_rts.*.id, count.index)}"
}
