module "rds" {
  source = "../tf-modules/rds"
  database_name = "web-applicationdb"
  engine = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.08.2"
  master_password = local.rds_master_password
  master_username = local.rds_master_username
  name = "${local.env}-${local.project}-auroradb"
  cluster_identifier = "${local.env}-${local.project}-auroradb"
  family = "aurora-mysql5.7"
  subnet_ids = [data.aws_subnet.private-subnet-1a.id, data.aws_subnet.private-subnet-1b.id, data.aws_subnet.private-subnet-1c.id]
  tags = merge(map("Name",join("-",[local.env,local.project,"auroradb"])),map("ResourceType","rds"),local.common_tags)
  vpc_security_group_ids = [aws_security_group.rds.id]
  instance_class = local.rds_instances_type
//  monitoring_role_arn = ""
  rds_instances_count = "1"
}