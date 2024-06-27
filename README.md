# ArgoCD Deployment on Amazon EKS with Terraform

This project automates the deployment of ArgoCD, a GitOps continuous delivery tool, on Amazon Elastic Kubernetes Service (EKS) using Terraform. It is structured into two main parts: the first part focuses on deploying ArgoCD itself with high availability and scalability configurations, while the second part handles the deployment of the ArgoCD root application, enabling the management of multiple applications and environments through a single ArgoCD instance. Together, these parts provide a comprehensive solution for leveraging GitOps principles for continuous delivery in Kubernetes environments.

## Prerequisites

- **Amazon EKS Cluster**: Set up your EKS cluster by following the guidelines provided in my repo [AWS EKS Clusters Configuration](https://github.com/DimitryZH/eks-clusters)
- **Terraform**: Opt for Terraform Cloud to leverage its capabilities in automating the provisioning of EKS, triggered by GitHub configurations, thereby streamlining your deployment workflows.
- **kubectl**: Ensure kubectl is configured to facilitate communication with your EKS cluster, enabling you to manage and interact with your cluster resources directly.

# Part 1 `terraform_argocd_eks` folder

## Overview

This part automates the deployment of ArgoCD, a declarative, GitOps continuous delivery tool for Kubernetes, on Amazon Elastic Kubernetes Service (EKS). Utilizing Terraform for infrastructure as code (IaC), the setup includes a highly available (HA) ArgoCD configuration optimized for production environments.

## Features

- **High Availability (HA):** Ensures ArgoCD remains operational, even in the event of a node failure within the cluster.
- **Autoscaling:** Dynamically adjusts the number of ArgoCD components based on load, enhancing resource efficiency.
- **Redis HA:** Utilizes a highly available Redis setup to manage ArgoCD's in-memory data store requirements.
  [ArgoCD High Availability Documentation](https://argo-cd.readthedocs.io/en/release-2.5/operator-manual/high_availability/)
  [ArgoCD High Availability GitHub Repository](https://github.com/argoproj/argo-cd/tree/master/manifests/ha)

## Structure

- `deploy_argocd.tf`: Terraform module for deploying ArgoCD instances in development and production environments on EKS.
- `main.tf`: Contains the core Terraform configuration for deploying the ArgoCD Helm chart to an EKS cluster, including provider setup and Helm chart deployment.
- `argocd.yaml`: Specifies the ArgoCD Helm chart values, including HA configurations, autoscaling settings, and custom resource customizations.
- `variables.tf`: Defines input variables required for the Terraform configuration, such as the EKS cluster name and the ArgoCD Helm chart version.
- `outputs.tf`: Specifies output values that provide information about the deployed ArgoCD instance, including the ArgoCD version, Helm revision, and chart version.

## Configuration

Modify the deploy_argocd.tf and argocd.yaml files to customize the ArgoCD deployment according to your requirements. The deploy_argocd.tf file allows for the specification of different environments (e.g., development and production), while argocd.yaml contains settings for HA, autoscaling, and other ArgoCD configurations.

## Part 1. Conclusion

This part streamlines the deployment of a highly available and scalable ArgoCD instance on Amazon EKS, leveraging Terraform for infrastructure management and Helm for package deployment.

# Part 2 `terraform_argocd_root_eks` folder

## Overview

The `terraform_argocd_root_eks` folder contains Terraform configurations and Kubernetes manifest files necessary for deploying the root application of Argo CD. This setup is crucial for managing multiple applications and environments through a single Argo CD instance, providing a streamlined approach to continuous delivery in Kubernetes environments.

## Structure

- `main.tf`: This Terraform file is crucial for deploying the Argo CD root application manifest. It retrieves information about the specified Amazon EKS cluster and configures the Kubernetes provider with the necessary authentication details. Finally, it deploys the Argo CD root application manifest using the `kubernetes_manifest` resource.
- `root.yaml`: A YAML file that defines the Argo CD Application resource, representing the root application. It includes specifications for the application's source and destination, sync policy, and other configurations. The file uses placeholders for the repository URL, path, and target revision, which are replaced with actual values during the Terraform deployment process.

- `variables.tf`: Contains the variable declarations required for deploying the Argo CD root application. It includes variables for the EKS cluster name, GitSource repository URL, path, and target revision. These variables are essential for tailoring the deployment to specific environments and Git repositories.

- `deploy_argocd.tf`: Demonstrates how to use modules for deploying Argo CD in both development and production environments, as well as deploying applications using Argo CD. It showcases the modularity of Terraform configurations, allowing for separate management of Argo CD instances and application deployments in different environments.

## Features

- **Root Application Deployment:** Automates the deployment of the Argo CD root application, which serves as the entry point for managing all other applications within the cluster.
- **Modular Configuration:** Supports separate deployments for development and production environments, enhancing deployment flexibility and environment-specific configurations.
- **EKS Cluster Integration:** Seamlessly integrates with Amazon EKS, utilizing Terraform to configure and deploy resources efficiently.

## Configuration

Modify the `main.tf`, `root.yaml`, and `variables.tf` files to customize the deployment according to your requirements. These files allow for the specification of the EKS cluster details, Argo CD application settings, and other necessary configurations for deploying the root application.

## Part 2. Conclusion

The `terraform_argocd_root_eks` folder provides a comprehensive solution for deploying the Argo CD root application to an Amazon EKS cluster.

## Deployment Instructions

To deploy ArgoCD in a development environment, utilize the "argocd_dev" module located in the `deploy_argocd.tf` file. Ensure to comment out any other module references to avoid unintended deployments.

1. **Initialize Terraform:**
   ```shell
   terraform init
   ```
2. **Plan the Terraform Deployment:**
   ```shell
   terraform plan
   ```
3. **Apply the Terraform Configuration:**
   ```shell
   terraform apply
   ```
4. **Verify ArgoCD Successfully Installed:**
   - Update the kubeconfig file for your EKS cluster:
     ```shell
     aws eks update-kubeconfig --name demo-dev
     ```
   - Check if the ArgoCD namespaces are created:
     ```shell
     kubectl get namespaces
     ```
   - Verify all ArgoCD components are running:
     ```shell
     kubectl get all -n argocd
     ```
5. **Get Secret to Access Argo CD UI:**
   - Retrieve the ArgoCD admin password:
     ```shell
     kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
     ```
6. **Access Argo CD UI:**

   - Forward the ArgoCD server service port to your local machine:
     ```shell
     kubectl port-forward svc/argocd-server -n argocd 8080:443
     ```
   - Open your browser and navigate to `https://[IP]:8080`. Use `admin` as the username and the password retrieved in step 5.

7. **Configure SSH Access for ArgoCD to GitHub Repository:**

   - Generate SSH keys:
     ```shell
     ssh-keygen
     ```
   - Upload the public key to your GitHub repository under Settings > Deploy keys.
   - Add the private key to ArgoCD under Settings > Repositories, along with the repository's URL.
   - Test the connection to ensure it's properly set up.

8. **Set Up for Production Environment:**

   - Repeat steps 1-7 for the module "argocd_prod", ensuring to use a different port, such as 8081, for the ArgoCD UI.

9. **Deploy Root Applications:**

   - Uncomment the modules "argocd_dev_root" and "argocd_prod_root" in your Terraform configuration.
   - Initialize, plan, and apply your Terraform configuration:
     ```shell
     terraform init
     terraform plan
     terraform apply
     ```

10. **Verify Root Application Deployment:**

- Check ArgoCD to ensure the root application is correctly installed and operational for both environments.

## Next Steps

This project serves as a prerequisite for automating the deployment of applications using ArgoCD. For detailed instructions on deploying specific applications with ArgoCD, refer to [Automated Application Deployments with ArgoCD](https://github.com/DimitryZH/argo-cd-app). The configurations and setups established here lay the foundational infrastructure necessary for leveraging ArgoCD's capabilities in managing Kubernetes applications seamlessly.
