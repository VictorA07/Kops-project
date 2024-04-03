locals {
  project-name = "teamkops"
}

#create vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs             = ["eu-west-2a"]
  public_subnets  = ["10.0.1.0/24"]
  create_igw = true
  public_subnet_tags = {name = "${local.project-name}-pub-subnet"}
  tags = {
    Terraform = "true"
    Environment = "teamkops"
  }
}
# Security Group 
resource "aws_security_group" "kops_sg" {
  name        = "${local.project-name}-kops-sg"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project-name}-kops-sg"
  }
}