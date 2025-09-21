
variable "privatesubnets_id"{
    type=list(string)
}

variable "dbsubnetname"{
    type=string
}
variable "dbinstance" {
  type = object({
    name=string
    allocated_storage = string
    engine            = string
    engine_version    = string
    instance_class    = string
    parameter_group_name = string
  })
}
variable "dbcredentials" {
  type = object({
    username=string
    password=string
  }) 
}

