
# Configure all traffic in the public subnets to use the internet gateway
resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}-default-rt"
    KubernetesCluster = "${var.environment}"
  }
}

## Availability Zone Routing Tables
resource "aws_route_table" "az_rts" {
  count  = "${length(var.zones)}"
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat_gws.*.id, count.index)}"
  }

  tags {
    Env               = "${var.environment}"
    Name              = "${var.environment}-rt-az${count.index}"
    KubernetesCluster = "${var.environment}"
  }
}
