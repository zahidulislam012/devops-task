module "web-application-ami" {
  source = "../tf-module/ami"
  owner = ["self"]
  ami_name = ["${local.env}-${local.project}-web-application-*"]
}