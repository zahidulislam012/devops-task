data "aws_vpc" "web-application" {
  id = local.internal-vpc
}
data "aws_subnet" "public-subnet-1a" {
  id = local.public-subnet-block-1a
}
data "aws_subnet" "public-subnet-1b" {
  id = local.public-subnet-block-1b
}
data "aws_subnet" "public-subnet-1c" {
  id = local.public-subnet-block-1c
}
data "aws_subnet" "private-subnet-1a" {
  id = local.private-subnet-block-1a
}
data "aws_subnet" "private-subnet-1b" {
  id = local.private-subnet-block-1b
}
data "aws_subnet" "private-subnet-1c" {
  id = local.private-subnet-block-1c
}