# ============================================================================
# IAM MODULE - modules/iam/outputs.tf
# ============================================================================

output "eks_cluster_role_arn" {
  description = "ARN of EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_cluster_role_name" {
  description = "Name of EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.name
}

output "eks_node_role_arn" {
  description = "ARN of EKS node IAM role"
  value       = aws_iam_role.eks_node.arn
}

output "eks_node_role_name" {
  description = "Name of EKS node IAM role"
  value       = aws_iam_role.eks_node.name
}

output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  description = "ARN of the EKS node IAM role"
  value       = aws_iam_role.eks_node.arn
}

output "aws_auth_configmap_yaml" {
  description = "AWS auth ConfigMap for EKS"
  value       = yamlencode({
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "aws-auth"
      namespace = "kube-system"
    }
    data = {
      mapRoles = yamlencode(concat(
        [
          {
            rolearn  = aws_iam_role.eks_node.arn
            username = "system:node:{{EC2PrivateDNSName}}"
            groups = [
              "system:bootstrappers",
              "system:nodes"
            ]
          }
        ],
        var.additional_iam_roles
      ))
      mapUsers = yamlencode(var.additional_iam_users)
    }
  })
}

