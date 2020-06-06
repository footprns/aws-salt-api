variable "name" {}
variable "subnet_id" {}
variable "security_groups" {
  type = list
}



resource "aws_efs_file_system" "default" {

  tags = {
    Name = "${var.name}"
  }
}

output "id" {
  value = aws_efs_file_system.default.id
}
output "arn" {
  value = aws_efs_file_system.default.arn
}
output "dns_name" {
  value = aws_efs_file_system.default.dns_name
}

resource "aws_efs_mount_target" "default" {
  file_system_id = aws_efs_file_system.default.id
  subnet_id      = var.subnet_id
  security_groups = var.security_groups
}

resource "aws_efs_file_system_policy" "default" {
  file_system_id = aws_efs_file_system.default.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "efs-policy-wizard-84668613-a032-48ff-b4a1-eaa98430b90d",
    "Statement": [
        {
            "Sid": "efs-statement-cea7981e-751f-4d41-9a20-f5f04f8ea027",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRootAccess"
            ],
            "Resource": "${aws_efs_file_system.default.arn}"
        }
    ]
}
POLICY
}