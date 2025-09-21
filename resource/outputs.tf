output "networking" {
  value = var.create && length(module.networking) > 0 ? {
    vpc_id = {
      name = var.vpc_var.name
      id   = module.networking[0].vpc_id
    }
    public_subnets  = module.networking[0].public_subnets_id
    private_subnets = module.networking[0].private_subnets_id
    natgateway = {
      name = var.natgatewayname
      id   = module.networking[0].natGateway_id
    }
    internetgateway = {
      name = var.internetgatewayname
      id   = module.networking[0].internetGateway_id
    }
    elasticip = {
      name = var.Elasticipname
      id   = module.networking[0].ElasticIp
    }
    publicroutetableid = {
      name = var.PublicRouteTableName
      id   = module.networking[0].PublicRouteTable_id
    }
    privateroutetableid = {
      name = var.PrivateRouteTableName
      id   = module.networking[0].PrivateRouteTable_id
    }
  } : {}
}

output "Loadbalancer" {
  value = var.create && length(module.ALB) > 0 ? {
    LoadBalancerid  = module.ALB[0].loadbalancer
    SecurityGroupid = module.ALB[0].securitygroup
  } : {}
}

output "AutoScalingGroupId" {
  value = var.create && length(module.ASG) > 0 ? module.ASG[0].asg : {}
}

output "Database" {
  value = var.create && length(module.Database) > 0 ? {
    name      = module.Database[0].Database.name
    id        = module.Database[0].Database.id
    subnet_id = module.Database[0].Database_subnet
  } : {}
}
