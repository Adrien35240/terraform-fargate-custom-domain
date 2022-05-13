provider "aws" {
  region = var.default_region
}

resource "aws_ecr_repository" "helloworld" {
  name                 = "helloworld"
}
