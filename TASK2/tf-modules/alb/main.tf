resource "aws_lb" "alb" {
  name = var.name
  internal = var.internal
  load_balancer_type = "application"
  security_groups = var.security_groups
  subnets = var.subnets
  enable_deletion_protection = true
  tags = var.tags
}

#listener
resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2015-05"
  certificate_arn = var.certificate_arn
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "application/json"
      status_code = "503"
      message_body = "Request Path is invalid"
    }
  }
}

resource "aws_lb_listener" "redirection" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}