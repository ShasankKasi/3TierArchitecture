module "networking" {
  source          = "../modules/networking"
  vpcvar          = var.vpc_var
  subnetvar       = var.subnetvar
  internetgateway = var.internetgatewayname
  natgateway      = var.natgatewayname
  Elasticipname   = var.Elasticipname
  PublicRouteTableName = var.PublicRouteTableName
  PrivateRouteTableName = var.PrivateRouteTableName
}

module "ALB" {
  source            = "../modules/ALB"
  LoadBalancer      = var.loadbalancername
  vpc_id            = module.networking.vpc_id.id
  public_subnets_id = module.networking.public_subnets_id
  ingress_rules     = var.ingress_rules
  egress_rules      = var.egress_rules
}
module "ASG" {
  source                    = "../modules/ASG"
  AutoScalingGroup          = var.asgname
  target_group_arn          = module.ALB.target_group_arn
  private_subnets_id        = module.networking.private_subnets_id
  autoscalingsizeparameters = var.autoscalingsizeparameters
  launch_template           = var.launch_template
  cloudwatchalarm           = var.alarm
  Scalingpolicy             = var.scaling_policy
}
module "Database" {
  source         = "../modules/Database"
  privatesubnets = module.networking.private_subnets_id
  dbsubnetname   = var.dbsubnetname
  dbinstance     = var.dbinstance
  dbcredentials  = var.dbcredentials
}

