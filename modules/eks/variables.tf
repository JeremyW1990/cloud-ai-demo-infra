variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy EKS into"
  type        = string
}

variable "subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster" 
  type        = string
}