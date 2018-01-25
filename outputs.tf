#
## Module Outputs
#

output "vpc_id" {
  description = "The ID of the aws vpc which has been created"
  value       = "${aws_vpc.main.id}"
}

output "environment" {
  description = "The environment name for this cluster"
  value       = "${var.environment}"
}

output "default_rt_id" {
  description = "The ID for the default routing table, with IGW attached"
  value       = "${aws_route_table.default.id}"
}

output "elb_subnets" {
  description = "A map containing the subnet id's for the ELB subnets"
  value       = "${zipmap(aws_subnet.elb_subnets.*.availability_zone, aws_subnet.elb_subnets.*.id)}"
}

output "nat_subnets" {
  description = "A map containing the subnet id's for the NAT subnets"
  value       = "${zipmap(aws_subnet.nat_subnets.*.availability_zone, aws_subnet.nat_subnets.*.id)}"
}

output "dns_zone_id" {
  description = "The route53 zone id for the cluster"
  value       = "${aws_route53_zone.zone.*.id}"
}

output "zone_rt_id" {
  description = "A map containing the route table id per availability zone"
  value       = "${zipmap(var.zones, aws_route_table.az_rts.*.id)}"
}

output "elb_cidr" {
  description = "A map containing the availability zone to ELB network CIDR i.e. eu-west-1a -> 10.200.10.0/24"
  value       = "${zipmap(aws_subnet.elb_subnets.*.availability_zone, aws_subnet.elb_subnets.*.cidr_block)}"
}

output "nat_cidr" {
  description = "A map containing the availability zone to NAT network CIDR i.e. eu-west-1a -> 10.200.10.0/24"
  value       = "${zipmap(aws_subnet.nat_subnets.*.availability_zone, aws_subnet.nat_subnets.*.cidr_block)}"
}

output "nat_gateway_private_ips" {
  description = "A list of the NAT gateway private addresses"
  value       = ["${aws_nat_gateway.nat_gws.*.private_ip}"]
}

output "nat_gateway_public_ips" {
  description = "A list of the NAT gateway EIP public addresses"
  value       = ["${aws_nat_gateway.nat_gws.*.public_ip}"]
}

output "dns_zone" {
  description = "The DNS for this cluster"
  value       = "${var.dns_zone}"
}

output "ingress_sg" {
  description = "The default security group created for the ingress nodes"
  value       = "${aws_security_group.ingress.id}"
}

output "kms_id" {
  description = "If enabled this is the ID of the managed KMS key for the cluster"
  value       = "${aws_kms_key.kms.*.key_id}"
}

output "kops_logs_bucket" {
  description = "If enabled this is the name of the s3 bucket storing access logs for the kops state bucket"
  value       = "${aws_s3_bucket.kops_logs_bucket.*.id}"
}
