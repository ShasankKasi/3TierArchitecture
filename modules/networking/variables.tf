variable "vpcvar" {
  type = object({
    name       = string
    cidr_block = string
  })
  validation {
    condition     = can(cidrsubnet(var.vpcvar.cidr_block, 0, 0))
    error_message = "Invalid Cidr block"
  }
}

variable "subnetvar" {
  type = list(object({
    name       = string
    cidr_block = string
    public     = optional(bool, true)
    availability_zone=string
  }))

  validation {
    condition     = alltrue([for s in var.subnetvar : can(cidrsubnet(s.cidr_block, 0, 0))])
    error_message = "Invalid Cidr Block"
  }

}
variable "Elasticipname"{
  type=string

}
variable "internetgateway" {
  type = string
}

variable "natgateway" {
  type = string
}


variable "PublicRouteTableName" {
  type=string
}
variable "PrivateRouteTableName" {
  type=string
}