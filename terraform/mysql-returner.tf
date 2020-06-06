module "mysql-returner" {
  source = "./modules/mysql"
  name = "saltreturner"
  vpc_security_group_ids = ["${module.salt-master.id}"]
}
