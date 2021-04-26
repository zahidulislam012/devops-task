module "web-application-public-alb" {
  source = "../tf-module/alb"
  internal = false
  name = "${local.env}-${local.project}-public-alb"
  certificate_arn = module.admin-acm.acm-arn
  security_groups = [aws_security_group.public-alb-sg.id]
  subnets = [module.public-subnet-1a.subnet_id, module.public-subnet-1b.subnet_id, module.public-subnet-1c.subnet_id]
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