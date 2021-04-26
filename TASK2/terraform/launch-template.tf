module "web-application-lt" {
  source = "../tf-modules/launch-template"

  name     = "${local.env}-${local.project}-web-application"
  image_id = module.web-application-ami.ami_id
  key_name = module.web-application-keypair.name

  instance_type          = local.instance-type
  iam_instance_profile   = module.web-application-iam.aws_iam_instance_profile_arn
  vpc_security_group_ids = [aws_security_group.web-application-ec2.id]
  tags                   = merge(map("Name", join("-", [local.env, local.project, "web-application"])), map("ResourceType", "LT"), local.common_tags)
  instance_tags          = merge(map("Name", join("-", [local.env, local.project, "web-application"])), map("ResourceType", "EC2"), local.common_tags)
  volume_tags            = merge(map("Name", join("-", [local.env, local.project, "web-application"])), map("ResourceType", "EBS"), local.common_tags)
}