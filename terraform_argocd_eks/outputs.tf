#This file defines the output variables for the Argo CD application deployed using Terraform.
  
  
#  Represents the version of the Argo CD application deployed.
output "argocd_version" {
  value = helm_release.argocd.metadata[0].app_version
}
# Represents the version of the Argo CD application deployed.
output "helm_revision" {
  value = helm_release.argocd.metadata[0].revision
}
# Represents the version of the Helm chart used for deploying the Argo CD application.

output "chart_version" {
  value = helm_release.argocd.metadata[0].version
}
