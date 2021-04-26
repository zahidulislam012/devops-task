variable "name" {}
variable "port" {}
variable "vpc_id" {}
variable "tags" {
  type = map(string)
}
variable "tg_path" {}
variable "protocol" {
  default = "HTTP"
  type = string
}