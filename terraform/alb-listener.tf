# Listener for Jenkins ALB
resource "aws_lb_listener" "jenkins_listener" {
  load_balancer_arn = aws_lb.jenkins_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }
}

# Listener rule for /jenkins path
resource "aws_lb_listener_rule" "jenkins_path_rule" {
  listener_arn = aws_lb_listener.jenkins_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }

  condition {
    path_pattern {
      values = ["/jenkins", "/jenkins/*"]
    }
  }
}