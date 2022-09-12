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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
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

provider "kubernetes" {
  config_path = "~/.kube/config"
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