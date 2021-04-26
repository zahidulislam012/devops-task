output "endpoint" {
  value = aws_rds_cluster.aurora-cluster.endpoint
}
output "cluster-id" {
  value = aws_rds_cluster.aurora-cluster.id
}