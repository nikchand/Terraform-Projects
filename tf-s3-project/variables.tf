variable "aws_region" {
  description = "AWS region to create resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-terraform-s3-bucket-niki-12345"  # make it unique
}

variable "public_access" {
  description = "Whether the bucket should be public"
  type        = bool
  default     = true
}

