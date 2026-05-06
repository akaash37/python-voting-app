provider "aws" {
  region = "us-east-1"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "my-terraform-state-bucket-akashmaiyar22"  # must be globally unique

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Dev"
  }
}

# Enable versioning (to keep history of state files)
resource "aws_s3_bucket_versioning" "tf_state_bucket_versioning" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}