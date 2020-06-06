variable "name" {}
variable "vpc_id" {}
variable "service_name" {}
variable "route_table_id" {}


resource "aws_vpc_endpoint" "default" {
  vpc_id       = var.vpc_id
  service_name = var.service_name

  tags = {
    Environment = "${var.name}"
  }
}

resource "aws_vpc_endpoint_route_table_association" "default" {
  route_table_id  = var.route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.default.id
}