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

locals {
  pod_labels = {
    app = var.name
  }
}

# Create a simple Kubernetes Deployment to run an app
resource "kubernetes_deployment" "app" {
  metadata {
    name = var.name
  }

  spec {
    replicas = var.replicas

    template {
      metadata {
        labels = local.pod_labels
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = var.container_port
          }

          dynamic "env" {
            for_each = var.environment_variables
            content {
              name  = env.key
              value = env.value
            }
          }
        }
      }
    }

    selector {
      match_labels = local.pod_labels
    }
  }
}

# Create a simple Kubernetes Service to spin up a load balancer in front
# of the app in the Kubernetes Deployment.
resource "kubernetes_service" "app" {
  metadata {
    name = var.name
  }

  spec {
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = var.container_port
      protocol    = "TCP"
    }
    selector = local.pod_labels
  }
}
