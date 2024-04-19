# Create prometheus & grafana Server
resource "aws_instance" "promgraf-server" {
  ami                         = "ami-0b9932f4918a00c4f"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.promgraf_sg.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.keypair.key_name
  user_data                   = local.monitoring-script
  tags = {
    Name = "${local.project-name}-kops"
  }
}

# Security Group 
resource "aws_security_group" "promgraf_sg" {
  name        = "${local.project-name}-promgraf-sg"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "prometheus access"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "node exporter access"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "grafana access"
    from_port   = 3000
    to_port     = 3000
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
    Name = "${local.project-name}-promgraf-sg"
  }
}