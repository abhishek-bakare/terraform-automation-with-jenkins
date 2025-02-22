terraform {
  backend "s3" {
    bucket = "s3-terraform-tfstate-100"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "tfstate-dynamodb"
  }
}