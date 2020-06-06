module "imank-ssh-public-key" {
  source = "./modules/key-pair"
  key_name = "imank-ssh-public-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "salt-master" {
  source = "./modules/security-group"
  name = "salt-master"
  description = "Allow ssh inbound traffic"
  vpc_id = "vpc-4cc2dd2b" # default vpc
  ingress_rules = [
  {
    description = "SSH from Intenet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["110.227.204.2/32", "223.229.175.11/32", "122.169.93.70/32", "122.179.150.123/32", "223.229.159.63/32", "182.70.17.160/32", "122.169.63.143/32", "182.70.42.83/32", "223.229.208.230/32", "182.70.11.196/32", "192.168.0.0/24"]
  },
  {
    description = "RDP from Intenet"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["110.227.204.2/32", "223.229.175.11/32", "122.169.93.70/32", "122.179.150.123/32", "223.229.159.63/32", "182.70.17.160/32","122.169.63.143/32", "182.70.42.83/32", "223.229.208.230/32", "182.70.11.196/32", "192.168.0.0/24"]
  },
  {
    description = "CherryPy from Intenet"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },

  {
    description = "Tomcat from Intenet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Flask from Intenet"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "ALB from Intenet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "salt traffic"
    from_port   = 4505
    to_port     = 4505
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "salt traffic"
    from_port   = 4506
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "mysql traffic"
    from_port   = 3306
    to_port     = 3306
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