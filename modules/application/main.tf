
resource "aws_instance" "web" {
  for_each = var.aws_instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  
  user_data     = each.value.user_data
  
  tags = {
    Name = each.key
  }
}