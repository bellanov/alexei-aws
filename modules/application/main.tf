
resource "aws_instance" "ec2" {
  for_each      = var.aws_instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  user_data              = each.value.user_data
  vpc_security_group_ids = each.value.security_group_ids

  tags = {
    Name = each.key
  }
}