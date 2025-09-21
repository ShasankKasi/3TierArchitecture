variable "vpc_var" {
  type = object({
    name       = string
    cidr_block = string
  })
  default = {
    name       = "default-vpc"
    cidr_block = "10.0.0.0/16"
  }
}

variable "subnetvar" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = [
    {
      name              = "default-subnet-1"
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1a"
    },
    {
      name              = "default-subnet-2"
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-south-1b"
    }
  ]
}

variable "internetgatewayname" {
  type    = string
  default = "default-igw"
}

variable "natgatewayname" {
  type    = string
  default = "default-natgw"
}

variable "loadbalancername" {
  type    = string
  default = "default-alb"
}

variable "asgname" {
  type    = string
  default = "default-asg"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "autoscalingsizeparameters" {
  type = object({
    minsize         = number
    maxsize         = number
    desiredcapacity = number
  })
  default = {
    minsize         = 1
    maxsize         = 3
    desiredcapacity = 2
  }
}

variable "launch_template" {
  type = object({
    name          = string
    ami           = string
    instance_type = string
  })
  default = {
    name          = "default-launch-template"
    ami           = "ami-12345678"
    instance_type = "t2.micro"
  }
}

variable "dbsubnetname" {
  type    = string
  default = "default-db-subnet"
}

variable "dbinstance" {
  type = object({
    name                 = string
    allocated_storage    = string
    engine               = string
    engine_version       = string
    instance_class       = string
    parameter_group_name = string
  })
  default = {
    name                 = "default-db"
    allocated_storage    = "20"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    parameter_group_name = "default.mysql8.0"
  }
}

variable "dbcredentials" {
  type = object({
    username = string
    password = string
  })
  default = {
    username = "admin"
    password = "password123"
  }
}

variable "alarm" {
  type = object({
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
  })
  default = {
    alarm_name          = "default-alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 300
    statistic           = "Average"
    threshold           = 80
  }
}

variable "scaling_policy" {
  type = object({
    name               = string
    scaling_adjustment = number
    adjustment_type    = string
    cooldown           = number
  })
  default = {
    name               = "default-scaling-policy"
    scaling_adjustment = 1
    adjustment_type    = "ChangeInCapacity"
    cooldown           = 300
  }
}

variable "Elasticipname" {
  type    = string
  default = "default-eip"
}

variable "PublicRouteTableName" {
  type    = string
  default = "default-public-rt"
}

variable "PrivateRouteTableName" {
  type    = string
  default = "default-private-rt"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "create" {
  type    = bool
  default = true
}