variable "name" {}
variable "policy_arn" {}
variable "assume_role_policy" {}

resource "aws_iam_role" "default" {
  name = var.name

  assume_role_policy = <<POLICY
${var.assume_role_policy}
POLICY

  tags = {
    name = var.name
  }
}


resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = var.policy_arn
}

resource "aws_iam_instance_profile" "default" {
  name = var.name
  role = aws_iam_role.default.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.default.name
}
