resource "aws_lb_target_group" "TG" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  deregistration_delay = "45"
  stickiness {
    type = "lb_cookie"
    enabled = "false"
  }
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 5
    timeout = 5
    interval = 10
    protocol = "HTTP"
    path = var.tg_path
  }
  tags = var.tags
}