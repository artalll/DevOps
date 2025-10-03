provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "wordpress_key" {
  key_name   = "wordpress-key"
  public_key = file("/home/tal/.ssh/id_ed25519.pub")

}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = "vpc-0d4b33bb60926335e"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Wordpress"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.wordpress_key.key_name
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  user_data = file("userdata.sh")

  tags = {
    Name = "wordpress-terraform"
  }
}

output "public_ip" {
  value = aws_instance.wordpress.public_ip
}
