variable "tags" {
  type = map(string)
}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "name" {}
variable "family" {
  default = "aurora-mysql5.7"
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "engine" {
  default = "aurora-mysql"
  type = string
}
variable "engine_version" {}
variable "database_name" {}
variable "master_username" {}
variable "master_password" {}
variable "instance_class" {}
//variable "monitoring_role_arn" {}
variable "cluster_identifier" {}
variable "rds_instances_count" {}