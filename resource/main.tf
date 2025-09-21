
module "networking" {
  count            = var.create ? 1 : 0
  source           = "../modules/networking"
  vpcvar           = var.vpc_var
  subnetvar        = var.subnetvar
  internetgateway  = var.internetgatewayname
  natgateway       = var.natgatewayname
  Elasticipname    = var.Elasticipname
  PublicRouteTableName  = var.PublicRouteTableName
  PrivateRouteTableName = var.PrivateRouteTableName
}

module "ALB" {
  count             = var.create ? 1 : 0
  source            = "../modules/ALB"
  LoadBalancer      = var.loadbalancername
  vpc_id            = module.networking[0].vpc_id.id
  public_subnets_id = module.networking[0].public_subnets_id
  ingress_rules     = var.ingress_rules
  egress_rules      = var.egress_rules
}

module "ASG" {
  count                    = var.create ? 1 : 0
  source                   = "../modules/ASG"
  AutoScalingGroup         = var.asgname
  target_group_arn         = module.ALB[0].target_group_arn
  private_subnets_id       = module.networking[0].private_subnets_id
  autoscalingsizeparameters= var.autoscalingsizeparameters
  launch_template          = var.launch_template
  cloudwatchalarm          = var.alarm
  Scalingpolicy            = var.scaling_policy
}

module "Database" {
  count          = var.create ? 1 : 0
  source         = "../modules/Database"
  privatesubnets = module.networking[0].private_subnets_id
  dbsubnetname   = var.dbsubnetname
  dbinstance     = var.dbinstance
  dbcredentials  = var.dbcredentials
}
