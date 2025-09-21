resource "aws_autoscaling_group" "asg"{
    name = var.AutoScalingGroup
    launch_template {
      id=aws_launch_template.Template.id
    }
    min_size = var.autoscalingsizeparameters.minsize
    max_size = var.autoscalingsizeparameters.maxsize
    desired_capacity = var.autoscalingsizeparameters.desiredcapacity
    target_group_arns = [var.target_group_arn]
    health_check_type = "ELB"
    force_delete = true
    lifecycle {
        create_before_destroy = true
    }
    tag {
        key = "Name"
        value = var.AutoScalingGroup
        propagate_at_launch = true
    }
   vpc_zone_identifier = var.private_subnets_id

}


resource "aws_launch_template" "Template" {
   name=var.launch_template.name
   image_id =var.launch_template.ami
   instance_type = var.launch_template.instance_type
   tags = {
     key="Name"
     value=var.launch_template.name
   }
}

resource "aws_cloudwatch_metric_alarm" "alarm"{
    alarm_name = var.cloudwatchalarm.alarm_name
    comparison_operator = var.cloudwatchalarm.comparison_operator
    evaluation_periods = var.cloudwatchalarm.evaluation_periods
    metric_name = var.cloudwatchalarm.metric_name
    namespace = var.cloudwatchalarm.namespace
    period = var.cloudwatchalarm.period
    statistic = var.cloudwatchalarm.statistic
    threshold = var.cloudwatchalarm.threshold
    alarm_actions = aws_autoscaling_policy.asg_policy.*.arn 
    dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.asg.name
    }
    tags = {
      Name=var.cloudwatchalarm.alarm_name
    }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name=var.Scalingpolicy.name
  scaling_adjustment = var.Scalingpolicy.scaling_adjustment
  adjustment_type = var.Scalingpolicy.adjustment_type
  cooldown = var.Scalingpolicy.cooldown
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

