variable "AutoScalingGroup" {
  type = string
}

variable "target_group_arn"{
    type=string
}

variable "private_subnets_id"{
  type=list(string)
}

variable "autoscalingsizeparameters" {
  type = object({
    minsize =number
    maxsize=number
    desiredcapacity=number
  })
}
variable "launch_template" {
  type=object({
    name = string
    ami=string
    instance_type=string
  })
}

variable "cloudwatchalarm"{
  type=object({
    alarm_name = string
    comparison_operator=string
    evaluation_periods=number
    metric_name=string
    namespace=string
    period=number
    statistic=string
    threshold=number
  })
}

variable "Scalingpolicy" {
  type = object({
    name = string
    scaling_adjustment = number
    adjustment_type = string
    cooldown = number
  })
}