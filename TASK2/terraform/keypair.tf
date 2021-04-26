module "web-application-keypair" {
  source     = "../tf-modules/keypair"
  key_name   = "${local.env}-${local.project}-web-application"
  public_key = local.web-application-keypair
}