#Step 1-Without key pair+SG
resource "aws_instance" "web" {
  ami           = "ami-0851b76e8b1bce90b"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-tf.key_name
  tags = {
    Name = "2nd-tfInstance"
  }
}
