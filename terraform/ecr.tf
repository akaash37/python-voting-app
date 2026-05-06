resource "aws_ecr_repository" "python_app_repo" {
  name                 = "python_app"
  image_tag_mutability = "MUTABLE"

  tags = { Name = "PythonAppECR" }
}