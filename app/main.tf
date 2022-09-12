terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"

    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
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



variable "image_id" {
  type = string
}

module "webapp" {
  source         = "github.com/MForte93/devops-test//terraform/modules/services/k8s-app"
  name           = "webapp"
  image          = var.image_id
  replicas       = 2
  container_port = 5000
}