output "vpc_id"{
  value={
    name:aws_vpc.myvpc.tags.Name
    id:aws_vpc.myvpc.id
  }
}

output "subnets_id" {
  value = { for subnet in aws_subnet.subnet : subnet.tags.Name => subnet.id }
}

# Ensure only one subnet per AZ (first one if duplicates exist)
output "public_subnets_id" {
  value = [
    for subnet in distinct([
      for s in aws_subnet.subnet : {
        az = s.availability_zone
        id = s.id
      } if lookup(s.tags, "public", false)
    ]) : subnet.id
  ]
}

output "private_subnets_id" {
  value = [
    for subnet in distinct([
      for s in aws_subnet.subnet : {
        az = s.availability_zone
        id = s.id
      } if !lookup(s.tags, "public", false)
    ]) : subnet.id
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