# Purpose: This Terraform file is used to deploy the Argo CD root application manifest to an Amazon EKS cluster.

# Retrieve information about the Amazon EKS cluster
data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}

# Retrieve authentication information for the Amazon EKS cluster
data "aws_eks_cluster_auth" "this" {
  name = var.eks_cluster_name
}

# Configure the Kubernetes provider with the necessary authentication details
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  token                  = data.aws_eks_cluster_auth.this.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
}

# Deploy the Argo CD root application manifest
resource "kubernetes_manifest" "argocd_root" {
  manifest = yamldecode(templatefile("${path.module}/root.yaml", {
    path           = var.git_source_path
    repoURL        = var.git_source_repoURL
    targetRevision = var.git_source_targetRevision
  }))
}
