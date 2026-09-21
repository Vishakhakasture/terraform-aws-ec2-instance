# Key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# Default VPC
resource "aws_default_vpc" "default" {
}

# Security group
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add a Terraform generated security group"
  vpc_id      = aws_default_vpc.default.id // Interpolation - is a way in which you can inherit or extract the values from a terraform block

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }

  # Notes app
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Notes app"
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open outbound"
  }

  tags = {
    Name = "automate-sg"
  }
}

# EC2 instance
resource "aws_instance" "my_instance" {
  # count = 3 // meta argumet
  for_each = tomap({
    my-instance-1 = "t2.micro",
    my-instance-2 = "t2.medium"
  })                                                                            // meta agrument
  depends_on      = [aws_security_group.my_security_group, aws_key_pair.my_key] // meta arguments
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")
  root_block_device {
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}
