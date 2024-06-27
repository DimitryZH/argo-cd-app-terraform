# Module for deploying ArgoCD in the development environment
module "argocd_dev" {
  source           = "./terraform_argocd_eks"
  eks_cluster_name = "demo-dev"
  chart_version    = "5.46.7"
}

# Module for deploying ArgoCD in the production environment
module "argocd_prod" {
  source           = "./terraform_argocd_eks"
  eks_cluster_name = "demo-prod"
  chart_version    = "5.46.2"
}

<<<<<<< HEAD
# Module for deploying applications in the development environment using ArgoCD
# This module depends on the successful deployment of module "argocd_dev"
=======
module "argocd_prod" {
  source           = "./terraform_argocd_eks"
  eks_cluster_name = "demo-prod"
  chart_version    = "5.46.2"
}


# Can be deployed ONLY after ArgoCD deployment: depends_on = [module.argocd_dev]
>>>>>>> 29267303da4386769e6c1eee17ecef57a2b2ca4d
module "argocd_dev_root" {
  source             = "./terraform_argocd_root_eks"
  eks_cluster_name   = "demo-dev"
  git_source_path    = "demo-dev/applications"
  git_source_repoURL = "git@github.com:DimitryZH/argo-cd-app.git"
}

<<<<<<< HEAD
# Module for deploying applications in the production environment using ArgoCD
# This module depends on the successful deployment of module "argocd_prod"
=======
# Can be deployed ONLY after ArgoCD deployment: depends_on = [module.argocd_prod]
>>>>>>> 29267303da4386769e6c1eee17ecef57a2b2ca4d
module "argocd_prod_root" {
  source             = "./terraform_argocd_root_eks"
  eks_cluster_name   = "demo-prod"
  git_source_path    = "demo-prod/applications"
  git_source_repoURL = "git@github.com:DimitryZH/argo-cd-app.git"
}
