module "salt-master01-instance" {
  source = "./modules/ec2"
  name = "salt-master01"
  ami = "ami-0f7719e8b7ba25c61" # ubuntu
  instance_type = "t2.micro"
  key_name = module.imank-ssh-public-key.key_name
  vpc_security_group_ids = ["${module.salt-master.id}"]
  associate_public_ip_address = true
  # subnet_id = module.sales-subnet.id
  subnet_id = "subnet-cab073ac" # default vpc
  user_data = <<EOM
${file("${path.module}/install_master.sh")}
EOM
  # iam_instance_profile = module.iam-role.instance_profile_name
  iam_instance_profile = null
  get_password_data = false
  volume_type = "standard" # magnetic 
}

output "salt-master01-instance-public_ip" {
  value = module.salt-master01-instance.public_ip
}
