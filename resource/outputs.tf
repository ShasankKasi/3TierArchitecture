output "networking" {
  value = {
    vpc_id = {
      name = var.vpc_var.name
      id   = module.networking.vpc_id
    }
    public_subnets  = module.networking.public_subnets_id
    private_subnets = module.networking.private_subnets_id
    natgateway = {
      name = var.natgatewayname
      id   = module.networking.natGateway_id
    }
    internetgateway = {
      name = var.internetgatewayname
      id   = module.networking.internetGateway_id
    }
    elasticip = {
      name = var.Elasticipname
      id   = module.networking.ElasticIp
    }
    publicroutetableid = {
      name = var.PublicRouteTableName
      id   = module.networking.PublicRouteTable_id
    }
    privateroutetableid = {
      name = var.PrivateRouteTableName
      id   = module.networking.PrivateRouteTable_id
    }
  }
}

output "Loadbalancer" {
  value = {
    LoadBalancerid  = module.ALB.loadbalancer
    SecurityGroupid = module.ALB.securitygroup
  }
}
output "AutoScalingGroupId" {
  value = module.ASG.asg
}

output "Database" {
  value = {
    name      = module.Database.Database.name
    id        = module.Database.Database.id
    subnet_id = module.Database.Database_subnet
  }
}
