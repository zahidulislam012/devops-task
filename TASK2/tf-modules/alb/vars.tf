variable "name" {}

variable "internal" {
  type = bool
}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "certificate_arn" {}