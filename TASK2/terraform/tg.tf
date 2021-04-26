module "web-application-tg" {
  source = "../tf-module/tg/alb"
  name = "${local.env}-${local.project}-web-application"
  port = "8080"
  tags = merge(map("Name",join("-",[local.env,local.project,"web-application"])),map("ResourceType","tg"),local.common_tags)
  vpc_id = data.aws_vpc.recurring.id
  tg_path = "/"
}