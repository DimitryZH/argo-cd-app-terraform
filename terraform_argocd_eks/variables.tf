# This file defines the variables used in the Terraform configuration for deploying ArgoCD on an EKS cluster.

# Define the variable for the EKS cluster name.
variable "eks_cluster_name" {
  description = "EKS Cluster name to deploy ArgoCD"
  type        = string
}

# Define the variable for the Helm chart version of ArgoCD.
variable "chart_version" {
  description = "Helm Chart Version of ArgoCD: https://github.com/argoproj/argo-helm/releases"
  type        = string
  default     = "5.46.0"
}
