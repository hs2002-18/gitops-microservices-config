variable "aws_region" {
  description = "AWS region for the Terraform backend resources"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  type        = string
  default     = "terraform-state-lock"
}