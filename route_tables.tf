# Configure all traffic in the public subnets to use the internet gateway
resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-default-rt"
  }
}

## Availability Zone Routing Tables
## Will allow AZ resilient NAT routing
resource "aws_route_table" "az_rts" {
  count  = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat_gws.*.id, count.index)}"
  }

  tags {
    Env     = "${var.environment}"
    Product = "${var.product}"
    Name    = "${var.environment}-${var.product}-rt-az${count.index}"
  }
}
