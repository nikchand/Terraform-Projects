# -------------------------------
# Generate key pair dynamically
# -------------------------------
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "terraform-ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/terraform-ec2-key.pem"
}

# -------------------------------
# Security Group for SSH
# -------------------------------
resource "aws_security_group" "centos_sg" {
  name        = "centos-sg"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "centos-sg" })
}


# -------------------------------
# Launch EC2 instance
# -------------------------------
resource "aws_instance" "centos_instance" {
  ami                         = "ami-04f61de38eefc0882"
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = [aws_security_group.centos_sg.id]
  associate_public_ip_address = true

  tags = merge(var.tags, { Name = "centos-ec2" })
}


