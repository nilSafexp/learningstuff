provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIATVW25R2BW4RJIZLN"
  secret_key = var.secret_key
}

variable "secret_key" {
}
