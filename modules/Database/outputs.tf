output "Database"{
    value={
        name=var.dbinstance.name
        id=aws_db_instance.rds.id
        }
}


output "Database_subnet"{
    value=aws_db_subnet_group.dbsubnet.id
}