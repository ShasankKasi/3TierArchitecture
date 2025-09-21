resource "aws_db_subnet_group" "dbsubnet" {
  name       = var.dbsubnetname
  subnet_ids = var.private_subnets   # fixed list

  tags = {
    Name = var.dbsubnetname
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = var.dbinstance.allocated_storage
  db_name              = var.dbinstance.name
  engine               = var.dbinstance.engine
  engine_version       = var.dbinstance.engine_version != "" ? var.dbinstance.engine_version : null
  instance_class       = var.dbinstance.instance_class
  username             = var.dbcredentials.username
  password             = var.dbcredentials.password
  parameter_group_name = var.dbinstance.parameter_group_name
  skip_final_snapshot  = true
  multi_az             = true

  db_subnet_group_name = aws_db_subnet_group.dbsubnet.name  

  tags = {
    Name = var.dbinstance.name
  }
}
