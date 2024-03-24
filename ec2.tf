resource "aws_iam_instance_profile" "example" {
  name = "example_profile"
  role = aws_iam_role.example.name
}

resource "aws_instance" "example" {
  ami                    = "ami-0014871499315f25a"  #RHEL9.3
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_a.id
  associate_public_ip_address = true
  vpc_security_group_ids  = [aws_security_group.example.id]
  iam_instance_profile   = aws_iam_instance_profile.example.name
  user_data = file("userdata.sh")
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "ec2-example"
  }
}