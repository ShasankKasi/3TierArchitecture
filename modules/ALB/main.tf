resource "aws_lb" "loadbalancer" {
  name               = var.LoadBalancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SecGroup.id]
  subnets            = var.public_subnets_id 
  tags = {
    Name=var.LoadBalancer
  }
}

resource "aws_security_group" "SecGroup"{
    vpc_id = var.vpc_id
    dynamic "ingress" {
      for_each = var.ingress_rules
      content {
      from_port=ingress.value.from_port
      to_port=ingress.value.to_port 
      protocol=ingress.value.ip_protocol
      cidr_blocks=ingress.value.cidr_blocks
      }
    }
    dynamic "egress" {
      for_each = var.egress_rules
      content {
        from_port = egress.value.from_port
        to_port = egress.value.to_port
      protocol=egress.value.protocol
      cidr_blocks=egress.value.cidr_blocks
      }
    }
    tags = {
      Name = "${var.LoadBalancer}-security-group"
    }
}
resource "aws_lb_target_group" "targetgroup"{
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    tags={
        Name="${var.LoadBalancer}-target-group"
    }
    target_type = "instance"
}
resource "aws_lb_listener" "listener"{
    load_balancer_arn = aws_lb.loadbalancer.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.targetgroup.arn
    }
    tags = {
      Name = "${var.LoadBalancer}-listener"
    }

}


