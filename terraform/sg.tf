# ============================
# Get Self Public IP
# ============================
data "http" "myip" {
  url = "https://api.ipify.org"
}

locals {
  my_ip = "${chomp(data.http.myip.response_body)}/32"
}

# ============================
#  Bastion Host SG
# ============================
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH only from my IP"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from self IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BastionSG"
  }
}

# ============================
#  Private Instances SG
# ============================
resource "aws_security_group" "private_sg" {
  name        = "private-instance-sg"
  description = "Allow all internal traffic within VPC"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "All internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PrivateInstanceSG"
  }
}

# ============================
#  Public Web SG
# ============================
resource "aws_security_group" "public_web_sg" {
  name        = "public-web-sg"
  description = "Allow HTTP & SSH from anywhere"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicWebSG"
  }
}