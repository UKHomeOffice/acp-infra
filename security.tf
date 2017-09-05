## The default ingress security group for ingress nodes
resource "aws_security_group" "ingress" {
  name        = "${var.environment}-ingress-sg"
  description = "The default security group for ingress nodes in environment: ${var.environment}"
  vpc_id      = "${aws_vpc.main.id}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.ingress_sg_name, var.dns_zone)),
    map("Env", var.environment))}"
}

# permit all outbound traffic from subnet
resource "aws_security_group_rule" "ingress_all_allow_outbound" {
  type              = "egress"
  security_group_id = "${aws_security_group.ingress.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}

## Permit all inbound connections from the ELB layer to service ports
resource "aws_security_group_rule" "ingress_node_ports_32000" {
  count = "${length(var.zones)}"

  type              = "ingress"
  security_group_id = "${aws_security_group.ingress.id}"
  protocol          = "tcp"
  from_port         = "30000"
  to_port           = "32767"
  cidr_blocks       = ["${element(aws_subnet.elb_subnets.*.cidr_block, count.index)}"]
}

## The default sysdig security group for sysdig nodes
resource "aws_security_group" "sysdig" {
  name        = "${var.environment}-sysdig-sg"
  description = "The default security group for sysdig-collector nodes in environment: ${var.environment}"
  vpc_id      = "${aws_vpc.main.id}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.sysdig_sg_name, var.dns_zone)),
    map("Env", var.environment))}"
}

# permit all outbound traffic from subnet
resource "aws_security_group_rule" "sysdig_all_allow_outbound" {
  type              = "egress"
  security_group_id = "${aws_security_group.sysdig.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}

## Permit all inbound connections from the ELB layer to service ports
resource "aws_security_group_rule" "sysdig_node_ports_32000" {
  count = "${length(var.zones)}"

  type              = "ingress"
  security_group_id = "${aws_security_group.sysdig.id}"
  protocol          = "tcp"
  from_port         = "30000"
  to_port           = "32767"
  cidr_blocks       = ["${element(aws_subnet.elb_subnets.*.cidr_block, count.index)}"]
}
