resource "aws_security_group" "web-application-public-alb" {
  name       = "${local.env}-web-application-public-alb"
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For App to  middleware communication"
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private-subnet-1a.cidr_block, data.aws_subnet.private-subnet-1b.cidr_block, data.aws_subnet.private-subnet-1c.cidr_block]
    description = "Load balancer to middleware communication"
  }
  tags = {
    Name          = "${local.env}-web-application-public-alb"
    Resource_Type = "SG"
    Environment   = local.environment
    Version       = local.version
    Developer     = local.developer
    Cost_Center   = local.cost-center
    Project       = local.project
  }
}

resource "aws_security_group" "web-application-ec2" {
  name   = "${local.env}-web-application-ec2"
  vpc_id = data.aws_vpc.web-application.id
  depends_on = [
    aws_vpc.vpc,
    aws_security_group.ctob-public-alb,
  ]
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [aws_security_group.web-application-public-alb.id]
    description = "For App to  middleware communication"
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //Need mastercard IP
    description = "to reach YUM repositories"
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //Need mastercard IP
    description = "Rest API call to AWS services"
  }
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private-subnet-1a.cidr_block, data.aws_subnet.private-subnet-1b.cidr_block, data.aws_subnet.private-subnet-1c.cidr_block]
    description = "To reache AURORA mysql RDS"
  }
  tags = {
    Name          = "${local.env}-web-application-ec2"
    Resource_Type = "SG"
    Environment   = local.environment
    Version       = local.version
    Developer     = local.developer
    Cost_Center   = local.cost-center
    Project       = local.project
  }
}

resource "aws_security_group" "rds" {
  name = "${local.env}-${local.project}-rds"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [aws_security_group.web-application-ec2.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name",join("-",[local.env,local.project,"rds"])),map("ResourceType","sg"),local.common_tags)
}