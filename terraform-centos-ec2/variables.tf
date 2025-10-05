variable "aws_region" {
  description = "AWS region to launch EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default = {
    Project = "terraform-centos-ec2"
    Owner   = "Nikki"
  }
}

