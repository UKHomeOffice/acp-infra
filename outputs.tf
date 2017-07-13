#
## Module Outputs
#

output "vpc_id"                  { value = "${aws_vpc.main.id}" }
output "default_rt_id"           { value = "${aws_route_table.default.id}"}

output "elb_subnets"             { value = "${zipmap(aws_subnet.elb_subnets.*.availability_zone, aws_subnet.elb_subnets.*.id)}" }
output "nat_subnets"             { value = "${zipmap(aws_subnet.nat_subnets.*.availability_zone, aws_subnet.nat_subnets.*.id)}" }
output "zone_rt_id"              { value = "${zipmap(aws_subnet.nat_subnets.*.availability_zone, aws_route_table.az_rts.*.id)}" }
output "elb_cidr"                { value = "${zipmap(aws_subnet.elb_subnets.*.availability_zone, aws_subnet.elb_subnets.*.cidr_block)}" }
output "nat_cidr"                { value = "${zipmap(aws_subnet.nat_subnets.*.availability_zone, aws_subnet.nat_subnets.*.cidr_block)}" }

output "nat_gateway_private_ips" { value = [ "${aws_nat_gateway.nat_gws.*.private_ip}" ] }
output "nat_gateway_public_ips"  { value = [ "${aws_nat_gateway.nat_gws.*.public_ip}" ] }
