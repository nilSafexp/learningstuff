# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIATVW25R2BW4RJIZLN"
  secret_key = "${var.secret_key}"
}

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}

//output "keyname" {
//  value = aws_key_pair.key-tf.key_name
//}
