terraform {    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
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


provider "aws" {
  region = "us-east-2"
}
 
module "eks_cluster" {
  source = "github.com/brikis98/terraform-up-and-running-code//code/terraform/07-working-with-multiple-providers/modules/services/eks-cluster?ref=v0.3.0"
  name = "terraform-learning"
  min_size     = 2
  max_size     = 2
  desired_size = 2
  instance_types = ["t3.small"]
} 
