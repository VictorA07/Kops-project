# Creating keypair
resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "keypair" {
  content         = tls_private_key.keypair.private_key_pem
  filename        = "jenkins-keypair.pem"
  file_permission = "600"
}
resource "aws_key_pair" "keypair" {
  key_name   = "jenkins-keypair"
  public_key = tls_private_key.keypair.public_key_openssh
}

# Create kops Server
resource "aws_instance" "kops-server" {
  ami                         = " "
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.kops_sg.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.keypair.key_name
  user_data                   = local.script
  tags = {
    name = "${local.project-name}-kops"
  }
}
