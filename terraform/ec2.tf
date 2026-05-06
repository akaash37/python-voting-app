# Bastion Host
resource "aws_instance" "bastion" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = aws_key_pair.c37_key.key_name
  associate_public_ip_address = true
  tags = { Name = "BastionHost" }
}

# Jenkins Instance
resource "aws_instance" "jenkins" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.c37_key.key_name
  tags = { Name = "JenkinsServer" }
}

# App Instance
resource "aws_instance" "app" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_b.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.c37_key.key_name
  tags = { Name = "AppServer" }
}