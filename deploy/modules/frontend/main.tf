provider "aws" {
  region  = var.default_region
}
resource "aws_ecr_repository" "test" {
    name = "${var.app_name}"
}
