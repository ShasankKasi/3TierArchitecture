vpc_var = { 
  cidr_block = "10.0.0.0/16"
  name       = "vpc1" 
}

subnetvar = [
  { name = "public-subnet-1", cidr_block = "10.0.1.0/24", public = true,  availability_zone = "ap-south-1b" },
  { name = "public-subnet-2", cidr_block = "10.0.2.0/24", public = true,  availability_zone = "ap-south-1a" },
  { name = "private-subnet-1", cidr_block = "10.0.3.0/24", public = false, availability_zone = "ap-south-1a" },
  { name = "private-subnet-2", cidr_block = "10.0.4.0/24", public = false, availability_zone = "ap-south-1b" },
  { name = "private-subnet-3", cidr_block = "10.0.5.0/24", public = false, availability_zone = "ap-south-1a" },
  { name = "private-subnet-4", cidr_block = "10.0.6.0/24", public = false, availability_zone = "ap-south-1b" },
]

natgatewayname        = "testNatgateway"
internetgatewayname   = "testInternetGateway"
loadbalancername      = "testALB"
asgname               = "testASG"
PrivateRouteTableName = "testPrivateRouteTable"
PublicRouteTableName  = "testPublicRouteTable"

ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

autoscalingsizeparameters = {
  minsize         = 1
  maxsize         = 3
  desiredcapacity = 2
}

launch_template = {
  name          = "WordPressLaunchTemplate"
  ami           = "ami-0d6f7f3fa71547f39" # ✅ Valid Amazon Linux 2 AMI for ap-south-1
  instance_type = "t2.micro"
}

dbsubnetname = "testrdsdatabase"

dbinstance = {
  name                 = "testRDSInstance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.36"   # ✅ Supported MySQL version
  instance_class       = "db.t3.micro" # ✅ Compatible instance type
  parameter_group_name = "default.mysql8.0"
}

dbcredentials = {
  username = "test"
  password = "test123"
}

alarm = {
  alarm_name          = "Testalarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
}

scaling_policy = {
  name               = "test_scaling"
  scaling_adjustment = 2
  adjustment_type    = "ChangeInCapacity"
  cooldown           = 250
}

Elasticipname = "testElasticIp"
