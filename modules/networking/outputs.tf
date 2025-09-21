# vpc id
output "vpc_id" {
  value = {
    name = aws_vpc.myvpc.tags.Name
    id   = aws_vpc.myvpc.id
  }
}

# all subnets by name
output "subnets_id" {
  value = { for subnet in aws_subnet.subnet : subnet.tags.Name => subnet.id }
}
# All public subnets as a list
output "public_subnets_id" {
  value = [for s in values(aws_subnet.subnet) : s.id if lookup(s.tags, "public", false)]
}

# All private subnets as a list
output "private_subnets_id" {
  value = [for s in values(aws_subnet.subnet) : s.id if !lookup(s.tags, "public", false)]
}
# internet gateway
output "internetGateway_id" {
  value = {
    name = aws_internet_gateway.name.tags.Name
    id   = aws_internet_gateway.name.id
  }
}

# NAT gateway
output "natGateway_id" {
  value = {
    name = aws_nat_gateway.name.tags.Name
    id   = aws_nat_gateway.name.id
  }
}

# route tables
output "PublicRouteTable_id" {
  value = {
    name = aws_route_table.public.tags.Name
    id   = aws_route_table.public.id
  }
}

output "PrivateRouteTable_id" {
  value = aws_route_table.private.id
}

# elastic IP
output "ElasticIp" {
  value = aws_eip.elasticip.id
}
