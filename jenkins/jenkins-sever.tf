# Jenkins Ssecurity group
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "jenkins secyrity group"
  vpc_id      = module.vpc.vpc.id

  # Inbound Rules
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "jenkins-port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_instance" "jenkins-server" {
  ami = "ami-05f804247228852a3"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  subnet_id = module.publicsubnet[0].id
  key_name = aws_key_pair.keypair.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.jenkins-role.id
  user_data = local.script
  tags = {
    Name = "jenkins-server"
  }
}
#IAM role

resource "aws_iam_role" "jenkins-ec2-role" {
  name = "jenkins-ec2-role"
  assume_role_policy = "${file("${path.root}/ec2-assume.json")}"
}
resource "aws_iam_instance_profile" "jenkins-role" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins-ec2-role.name
}
resource "aws_iam_role_policy_attachment" "jenkins-role-att" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.jenkins-ec2-role.name
}