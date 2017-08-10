## The default compute security group for compute nodes
resource "aws_security_group" "compute" {
  name        = "${var.environment}-compute-sg"
  description = "The default security group for compute nodes in environment: ${var.environment}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.compute_sg_name, var.dns_zone)),
    map("Env", var.environment))}"
}

## The default master security group for master nodes
resource "aws_security_group" "master" {
  name        = "${var.environment}-master-sg"
  description = "The default security group for master nodes in environment: ${var.environment}"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.master_sg_name, var.dns_zone)),
    map("Env", var.environment))}"
}

# Permit all traffic internal to the master subnet
resource "aws_security_group_rule" "master_all_allow" {
  type              = "ingress"
  security_group_id = "${aws_security_group.master.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  self              = true
}

# Permit all outbound traffic from subnet
resource "aws_security_group_rule" "master_all_allow_outbound" {
  type              = "egress"
  security_group_id = "${aws_security_group.master.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Permit all traffic internal to the compute subnet
resource "aws_security_group_rule" "compute_all_allow" {
  type              = "ingress"
  security_group_id = "${aws_security_group.compute.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  self              = true
}

# Permit all outbound traffic from subnet
resource "aws_security_group_rule" "compute_all_allow_outbound" {
  type              = "egress"
  security_group_id = "${aws_security_group.compute.id}"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  cidr_blocks       = ["0.0.0.0/0"]
}

## Permit flannel vxlan udp from compute
resource "aws_security_group_rule" "secure_permit_vxlan" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.master.id}"
  protocol                 = "udp"
  from_port                = "8472"
  to_port                  = "8472"
  source_security_group_id = "${aws_security_group.compute.id}"
}

## Permit kube api from compute
resource "aws_security_group_rule" "secure_permit_443" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.master.id}"
  protocol                 = "tcp"
  from_port                = "443"
  to_port                  = "443"
  source_security_group_id = "${aws_security_group.compute.id}"
}

## Permit kube api from compute
resource "aws_security_group_rule" "secure_permit_6443" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.master.id}"
  protocol                 = "tcp"
  from_port                = "6443"
  to_port                  = "6443"
  source_security_group_id = "${aws_security_group.compute.id}"
}

## Permit Kubernetes Exec client from secure api
resource "aws_security_group_rule" "compute_permit_10250" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.compute.id}"
  protocol                 = "tcp"
  from_port                = "10250"
  to_port                  = "10250"
  source_security_group_id = "${aws_security_group.master.id}"
}

## Permit all inbound connections from the ELB layer to service ports
resource "aws_security_group_rule" "compute_node_ports_32000" {
  count = "${length(var.zones)}"

  type              = "ingress"
  security_group_id = "${aws_security_group.compute.id}"
  protocol          = "tcp"
  from_port         = "30000"
  to_port           = "32767"
  cidr_blocks       = ["${element(aws_subnet.elb_subnets.*.cidr_block, count.index)}"]
}

# Permit all traffic from master to the compute subnet
resource "aws_security_group_rule" "permit_all_from_master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.compute.id}"
  protocol                 = "-1"
  from_port                = "0"
  to_port                  = "0"
  source_security_group_id = "${aws_security_group.master.id}"
}
