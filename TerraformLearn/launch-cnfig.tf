data "aws_launch_configuration" "ngix" {
  name = "test-nginx-config"
  instance_type = "t2.micro"
  ami_id = "ami-0b607804aa28ec617"
  security_groups = "sg-08bbb03b52f97b9a0"
}
  lifecycle {
    create_before_destroy = true
  }
