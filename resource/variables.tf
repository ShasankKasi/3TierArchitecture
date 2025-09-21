variable "vpc_var" {
  type = object({
    name       = string
    cidr_block = string
  })
}


variable "subnetvar" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "internetgatewayname" {
  type = string
}

variable "natgatewayname" {
  type = string
}

variable "loadbalancername" {
  type = string
}

variable "asgname" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "autoscalingsizeparameters" {
  type = object({
    minsize         = number
    maxsize         = number
    desiredcapacity = number
  })
}

variable "launch_template" {
  type = object({
    name          = string
    ami           = string
    instance_type = string
  })
}

variable "dbsubnetname" {
  type = string
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
}
variable "dbcredentials" {
  type = object({
    username = string
    password = string
  })
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
}

variable "scaling_policy" {
  type = object({
    name               = string
    scaling_adjustment = number
    adjustment_type    = string
    cooldown           = number
  })
}
variable "Elasticipname" {
  type = string

}

variable "PublicRouteTableName"{
  type=string
}

variable "PrivateRouteTableName"{
  type=string
}

variable "region" {
  type = string
  default = "ap-south-1"
}
variable "create" {
  type    = bool
  default = true
}
