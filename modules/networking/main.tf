
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpcvar.cidr_block
  tags = {
    Name = var.vpcvar.name
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}



resource "aws_subnet" "subnet" {
  for_each = { for i, s in var.subnetvar : i=> s }
  availability_zone = each.value.availability_zone

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.myvpc.id
  
  tags = {
    Name = each.value.name
    public = each.value.public
  }
}


resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = var.internetgateway
  }
}


resource "aws_route_table" "public" {
  tags = {
    Name = var.PublicRouteTableName
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

resource "aws_route_table" "private" {
  tags = {
    Name = var.PrivateRouteTableName
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }
}
resource "aws_route_table_association" "publicassociation" {
  for_each       = { for s in aws_subnet.subnet : s.tags.Name => s if s.tags.public }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "privateassociation" {
  for_each       = { for s in aws_subnet.subnet : s.tags.Name => s if !s.tags.public }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "elasticip" {
  domain = "vpc"
  tags = {
    "key" = "Name"
    "value" = var.Elasticipname
  }
}
locals {
  public_subnets={for s in aws_subnet.subnet : s.tags.Name => s if s.tags.public}
}
locals {
  private_subnets={for s in aws_subnet.subnet : s.tags.Name => s if !s.tags.public}
}

resource "aws_nat_gateway" "name" {
  tags = {
    Name = var.natgateway
  }
  subnet_id       =local.public_subnets[keys(local.public_subnets)[0]].id
  depends_on = [aws_eip.elasticip]
  connectivity_type = "public"
  allocation_id = aws_eip.elasticip.id
}
