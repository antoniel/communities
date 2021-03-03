locals {
  org  = "n2n2"
  name = "tribes"
  env  = ["stag"]
  # env    = ["stag", "prod"]
  region = "us-east-1"

  # git_conn_arn = "arn:aws:codestar-connections:us-east-1:724178372978:connection/8b658c00-d2c4-470f-98db-529ca8ff67f3"
  # git_org      = "portfolioinsider"
  # git_repo     = format("%s/%s", local.git_org, "pi-quodd-socket")
  # git_branch = {
  #   prod = "main"
  #   stag = "staging"
  # }

  common_tags = {
    region    = local.region
    terraform = true
  }
}

terraform {
  # terraform state storage
  backend "s3" {
    bucket         = "n2n2-terra-state"
    key            = "apps/n2n2-tribes/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "n2n2-terra-state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
