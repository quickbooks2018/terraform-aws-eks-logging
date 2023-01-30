output "vpc" {
  value = module.eks_vpc
}

output "eks" {
  value = module.eks
}

output "elasticsearch" {
  value = module.elasticsearch
}


output "iam_eks-fluent-bit-service-account-policy" {
    value       = module.iam_eks-fluent-bit-service-account-policy
    description = "All attributes of the created IAM policy"
  }

output "iam_eks-fluent-bit-service-account-role" {
    value       = module.iam-assumable-role-with-oidc-just-like-iam-role-attachment-to-ec2
    description = "All attributes of the created IAM role"
  }