variable "LoadBalancer"{
    type =string
}

variable "vpc_id"{
    type = string
}

variable "public_subnets_id"{
    type = list(string)
}

variable "ingress_rules" {
  type=list(object({
    from_port = number
    to_port=number
    ip_protocol=string
    cidr_blocks=list(string)
  }))
}
variable "egress_rules" {
  type=list(object({
    from_port = number
    to_port=number
    protocol=string
    cidr_blocks=list(string)
  }))
}