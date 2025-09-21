module "networking" {
  count                   = try(coalesce(var.create), false) ? 1 : 0
  source                  = "../modules/networking"
  vpcvar                  = try(coalesce(var.vpc_var), null)
  subnetvar               = try(coalesce(var.subnetvar), null)
  internetgateway         = try(coalesce(var.internetgatewayname), null)
  natgateway              = try(coalesce(var.natgatewayname), null)
  Elasticipname           = try(coalesce(var.Elasticipname), null)
  PublicRouteTableName    = try(coalesce(var.PublicRouteTableName), null)
  PrivateRouteTableName   = try(coalesce(var.PrivateRouteTableName), null)
}

module "ALB" {
  count             = try(coalesce(var.create), false) ? 1 : 0
  source            = "../modules/ALB"
  LoadBalancer      = try(coalesce(var.loadbalancername), null)
  vpc_id            = try(coalesce(module.networking[0].vpc_id.id), null)
  public_subnets_id = try(coalesce(module.networking[0].public_subnets_id), null)
  ingress_rules     = try(coalesce(var.ingress_rules), null)
  egress_rules      = try(coalesce(var.egress_rules), null)
}

module "ASG" {
  count                      = try(coalesce(var.create), false) ? 1 : 0
  source                     = "../modules/ASG"
  AutoScalingGroup           = try(coalesce(var.asgname), null)
  target_group_arn           = try(coalesce(module.ALB[0].target_group_arn), null)
  private_subnets_id         = try(coalesce(module.networking[0].private_subnets_id), null)
  autoscalingsizeparameters  = try(coalesce(var.autoscalingsizeparameters), null)
  launch_template            = try(coalesce(var.launch_template), null)
  cloudwatchalarm            = try(coalesce(var.alarm), null)
  Scalingpolicy              = try(coalesce(var.scaling_policy), null)
}

module "Database" {
  count          = try(coalesce(var.create), false) ? 1 : 0
  source         = "../modules/Database"
  privatesubnets = try(coalesce(module.networking[0].private_subnets_id), null)
  dbsubnetname   = try(coalesce(var.dbsubnetname), null)
  dbinstance     = try(coalesce(var.dbinstance), null)
  dbcredentials  = try(coalesce(var.dbcredentials), null)
}