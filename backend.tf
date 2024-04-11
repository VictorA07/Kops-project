terraform {
  backend "s3" {
    bucket = "kops-server-sockshop"
    key = "kops-server/tfstate"
    dynamodb_table = "kops-sockshop"
    region = "eu-west-2"
    encrypt = true
    profile = "team1"
  }
}
