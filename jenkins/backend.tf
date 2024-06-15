terraform {
  backend "s3" {
    bucket = "kops-server-sockshop"
    key = "jenkins-server/tfstate"
    dynamodb_table = "kops-sockshop"
    region = "eu-west-2"
    encrypt = true
    profile = "lead"
  }
}
