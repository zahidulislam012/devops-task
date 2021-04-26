module "web-application-iam" {
  source = "../tf-modules/iam"
  name   = "${local.env}-${local.project}-web-application"
  policies = {
    AmazonS3FullAccess          = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonEC2RoleforSSM         = "arn:aws:iam::aws:policy/AmazonEC2RoleforSSM"
  }
}
