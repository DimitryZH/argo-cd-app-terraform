# This file is used to deploy the Argo CD Helm chart to an Amazon EKS cluster.

# Retrieve information about the Amazon EKS cluster
data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}

# Retrieve authentication information for the Amazon EKS cluster
data "aws_eks_cluster_auth" "this" {
  name = var.eks_cluster_name
}

# Configure the Helm provider to interact with the Kubernetes cluster
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  }
}

# Deploy the Argo CD Helm chart to the Kubernetes cluster
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm" # Official Chart Repo
  chart            = "argo-cd"                              # Official Chart Name
  namespace        = "argocd"
  version          = var.chart_version
  create_namespace = true
  values           = [file("${path.module}/argocd.yaml")]
}
