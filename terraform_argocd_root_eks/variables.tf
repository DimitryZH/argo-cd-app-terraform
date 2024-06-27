# This file contains the variable declarations for deploying the ArgoCD ROOT Application to an EKS cluster.

# Variable for specifying the name of the EKS cluster to deploy the ArgoCD ROOT Application
variable "eks_cluster_name" {
  description = "EKS Cluster name to deploy ArgoCD ROOT Application"
  type        = string
}

# Variable for specifying the GitSource repository URL to track and deploy to EKS by the ROOT Application
variable "git_source_repoURL" {
  description = "GitSource repoURL to Track and deploy to EKS by ROOT Application"
  type        = string
}

# Variable for specifying the GitSource path in the Git Repository to track and deploy to EKS by the ROOT Application
variable "git_source_path" {
  description = "GitSource Path in Git Repository to Track and deploy to EKS by ROOT Application"
  type        = string
  default     = ""
}

# Variable for specifying the GitSource HEAD or Branch to track and deploy to EKS by the ROOT Application
variable "git_source_targetRevision" {
  description = "GitSource HEAD or Branch to Track and deploy to EKS by ROOT Application"
  type        = string
  default     = "HEAD"
}
