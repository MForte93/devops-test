provider "aws" {
  region = "us-east-2"
}
 
module "eks_cluster" {
  source = "./terraform/modules/services/eks-cluster"
  name = "terraform-learning"
  min_size     = 2
  max_size     = 2
  desired_size = 2
  instance_types = ["t3.small"]
} 
