# Placeholder for compute module
resource "aws_instance" "web" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = true
  tags = { Name = "WebServer" }
}

resource "aws_ebs_volume" "web_data" {
  availability_zone = aws_instance.web.availability_zone
  size              = 8
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.web_data.id
  instance_id = aws_instance.web.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

