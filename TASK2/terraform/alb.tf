module "web-application-public-alb" {
  source = "../tf-module/alb"
  internal = false
  name = "${local.env}-${local.project}-public-alb"
  certificate_arn = module.acm.acm-arn
  security_groups = [aws_security_group.public-alb-sg.id]
  subnets = [data.aws_subnet.private-subnet-1a.id, data.aws_subnet.private-subnet-1b.id, data.aws_subnet.private-subnet-1c.id]
  tags = merge(map("Name",join("-",[local.env,local.project,"public-alb"])),map("ResourceType","ALB"),local.common_tags)
}


resource "aws_alb_listener_rule" "web-application" {
  listener_arn = module.web-application-public-alb.listener-arn
  priority = "99"
  action {
    type = "forward"
    target_group_arn = module.merchant-portal-backend-tg.tg_arn
  }
  condition {
    path_pattern {
      values = ["/merchant-portal-backend/*"]
    }
  }
}