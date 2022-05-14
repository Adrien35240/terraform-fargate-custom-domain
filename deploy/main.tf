provider "aws" {
  region  = "eu-west-3"
}
resource "aws_ecr_repository" "test" {
    name = "test"
    
}