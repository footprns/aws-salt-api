

module "salt-minion01-instance" {
  source = "./modules/ec2"
  name = "salt-minion01"
  ami = "ami-0f7719e8b7ba25c61" # ubuntu
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  vpc_security_group_ids = ["${module.salt-master.id}"]
  associate_public_ip_address = true
  # subnet_id = module.sales-subnet.id
  subnet_id = "subnet-cab073ac" # default vpc
  user_data = <<EOM
${file("${path.module}/install_minion.sh")}
EOM
  # iam_instance_profile = module.iam-role.instance_profile_name
  iam_instance_profile = null
  get_password_data = false
  volume_type = "standard" # magnetic 
}

output "salt-minion01-instance-public_ip" {
  value = module.salt-minion01-instance.public_ip
}
/*
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
*/
