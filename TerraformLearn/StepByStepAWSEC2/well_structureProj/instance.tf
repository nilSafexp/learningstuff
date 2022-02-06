#Instance creation steps
resource "aws_instance" "web" {
  # ami                    = "ami-0851b76e8b1bce90b"
  ami                    = var.image_id
  instance_type          = var.instance_type
  #key_name               = "test"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "well-structure-tfInstance"
  }
}