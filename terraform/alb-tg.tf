resource "aws_lb_target_group" "jenkins_tg" {
  name        = "jenkins-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id
  target_type = "instance"

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = { Name = "JenkinsTargetGroup" }
}

resource "aws_lb_target_group_attachment" "jenkins_tg_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}