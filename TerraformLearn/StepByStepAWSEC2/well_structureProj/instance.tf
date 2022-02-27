#Instance creation steps
resource "aws_instance" "web" {
  # ami                    = "ami-0851b76e8b1bce90b"
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = "final"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "well-structure-tfInstance"
  }
  user_data = file("${path.module}/ngi-test.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/final.pem")
    host        = self.public_ip
  }
  provisioner "file" {
    content     = "this is new content"
    destination = "/tmp/cont.md"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/txt.txt"
    }

  provisioner "local-exec" {
  command = "env> env.txt"
  environment = {
    envname = "envvalue"
   }
  }
  provisioner "local-exec" {
    working_dir = "/tmp/1/"
    when = destroy
    command = "echo at delete"
  }
}