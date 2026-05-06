# Allow ALB to access Jenkins EC2 on port 8080
resource "aws_security_group_rule" "allow_alb_to_jenkins" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_sg.id   # Jenkins EC2 SG
  source_security_group_id = aws_security_group.alb_sg.id       # ALB SG
}