variable "name" {}
variable "hash_key" {}
variable "range_key" {}
variable "attribute" {}
variable "billing_mode" {}


resource "aws_dynamodb_table" "default" {
    name = var.name
    hash_key       = var.hash_key
    range_key = var.range_key
    billing_mode = var.billing_mode
    read_capacity  = 1
    write_capacity = 1

  dynamic "attribute" {
  for_each = var.attribute
  content {
    name = attribute.value["name"]
    type = attribute.value["type"]
  }
}
}