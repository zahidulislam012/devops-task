#RDS aurora DB parameters Group
resource "aws_rds_cluster_parameter_group" "aurora-db-parameters" {
  name = var.name
  family = var.family
  parameter {
    name = "lower_case_table_names"
    value = "1"
    apply_method = "pending-reboot"
  }
  tags = var.tags
}

# RDS Subnet Group
resource "aws_db_subnet_group" "aurora-subnet" {
  name = var.name
  subnet_ids = var.subnet_ids
}

# RDS Cluster
resource "aws_rds_cluster" "aurora-cluster" {
  engine = var.engine
  engine_version = var.engine_version
  database_name = var.database_name
  cluster_identifier = var.cluster_identifier
  master_username = var.master_username
  master_password = var.master_password
  db_subnet_group_name = aws_db_subnet_group.aurora-subnet.id
  vpc_security_group_ids = var.vpc_security_group_ids
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-db-parameters.id
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  skip_final_snapshot = true
  backup_retention_period = "5"
  //  storage_encrypted = true
  //  kms_key_id = "${aws_kms_key.kms-key.arn}"
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]
  deletion_protection = true
  tags = var.tags
}

# RDS Cluster Instance
resource "aws_rds_cluster_instance" "aurora-instance" {
  engine = var.engine
  engine_version = var.engine_version
  cluster_identifier = aws_rds_cluster.aurora-cluster.id
  instance_class     = var.instance_class
  performance_insights_enabled = false
  count = var.rds_instances_count
  identifier = "${var.cluster_identifier}-${count.index}"
  apply_immediately = false
//  monitoring_interval = 30
//  monitoring_role_arn = var.monitoring_role_arn
  tags = var.tags
}