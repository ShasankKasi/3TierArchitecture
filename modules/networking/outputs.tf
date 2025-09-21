output "vpc_id"{
  value={
    name:aws_vpc.myvpc.tags.Name
    id:aws_vpc.myvpc.id
  }
}

output "subnets_id" {
  value = { for subnet in aws_subnet.subnet : subnet.tags.Name => subnet.id }
}

# Pick exactly one public subnet per AZ
output "public_subnets_id" {
  value = [
    for az in distinct([for s in values(aws_subnet.subnet) : s.availability_zone if lookup(s.tags, "public", false)]) :
    # pick the first subnet in that AZ
    lookup(
      {for s in values(aws_subnet.subnet) : s.availability_zone => s.id if s.availability_zone == az && lookup(s.tags, "public", false)},
      az
    )
  ]
}

# Pick exactly one private subnet per AZ
output "private_subnets_id" {
  value = [
    for az in distinct([for s in values(aws_subnet.subnet) : s.availability_zone if !lookup(s.tags, "public", false)]) :
    lookup(
      {for s in values(aws_subnet.subnet) : s.availability_zone => s.id if s.availability_zone == az && !lookup(s.tags, "public", false)},
      az
    )
  ]
}



output "internetGateway_id"{
    value={
        name=aws_internet_gateway.name.tags.Name
        id=aws_internet_gateway.name.id
    }
}
output "natGateway_id"{
    value={
        name=aws_nat_gateway.name.tags.Name
        id=aws_nat_gateway.name.id
    }
}

output "PublicRouteTable_id"{
    value={
        name=aws_route_table.public.tags.Name
        id=aws_route_table.public.id

    }
}
output "PrivateRouteTable_id"{
    value = aws_route_table.private.id
}

output "ElasticIp"{
    value=aws_eip.elasticip.id

}