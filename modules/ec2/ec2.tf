resource "aws_instance" "web" {

  ami           = var.ami_name
  instance_type = var.instance_size
  subnet_id = var.public_subnet_id
  
  

  tags = {
    Name = "Shekhar "
  }
}

