variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key-pair name in AWS lab"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH from"
  type        = string
  default     = "0.0.0.0/0"
}

