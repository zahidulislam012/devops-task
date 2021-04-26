module "web-application-ami" {
  source = "../tf-modules/ami"
  owner = ["self"]
  ami_name = ["${local.env}-${local.project}-web-application-*"]
}