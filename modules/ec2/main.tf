resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.tag_prefix}-${terraform.workspace}-EC2"
  }
}
