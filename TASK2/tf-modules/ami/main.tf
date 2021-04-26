data "aws_ami" "ami" {
  filter {
    name = "state"
    values = ["available"]
  }
  filter {
    name = "name"
    values = var.ami_name
  }
  owners = var.owner
  most_recent = true
}