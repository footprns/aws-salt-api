variable "name" {}
variable "vpc_security_group_ids" {
  type = list
}


resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = var.name
  identifier = var.name
  username             = "admin"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = var.vpc_security_group_ids
}