module "salt-master-efs" {
  source = "./modules/efs"
  name = "salt-master-efs"
  subnet_id = "subnet-cab073ac" # default vpc
  security_groups = ["${module.salt-master-efs-sg.id}"] # allow efs
}

output "salt-master-efs" {
  value = module.salt-master-efs.dns_name
}

module "salt-master-efs-sg" {
  source = "./modules/security-group"
  name = "salt-master-efs-sg"
  description = "Allow efs inbound traffic"
  vpc_id = "vpc-4cc2dd2b" # default vpc
  ingress_rules = [
  {
    description = "EFS from ECS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }
  ]
  egress_rules = [
  {
    description = "Traffic to Intenet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ]
}
