output "loadbalancer"{
    value = aws_lb.loadbalancer.id
}

output "securitygroup"{
    value=aws_security_group.SecGroup.id
} 

output "target_group_arn"{
    value=aws_lb_target_group.targetgroup.arn
}