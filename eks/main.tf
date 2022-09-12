
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "gh-aws-actions"

    workspaces {
      name = "gh-aws-actions"
    }
  }
}

resource "random_pet" "sg" {}

provider "aws" {
  region = "us-east-2"
}
 
module "eks_cluster" {
  source = "../terraform/modules/services/eks-cluster"
  name = "terraform-learning"
  min_size     = 2
  max_size     = 2
  desired_size = 2
  instance_types = ["t3.small"]
} 
