data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS Region logs should be streamed to (defaults to current region)."
}
variable "fluent_bit_name" {
  type        = string
  default     = "fluent-bit"
  description = "Fluent-bit chart release name."
}

variable "cluster_name" {
  type = string
  # default     = ""
  description = "EKS cluster name fluent-bit will be installed in."
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "Namespace fluent-bit should be deployed into."
}

variable "create_namespace" {
  type        = bool
  default     = false
  description = "Wether or no to create namespace if namespace does not exist."
}

variable "eks_oidc_root_ca_thumbprint" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

# Auth data
variable "cluster_host" {
  type = string
}

variable "cluster_certificate" {
  type = string
}

variable "cluster_token" {
  type = string
}

variable "bucket_name" {
  type        = string
  default     = "fluentbit-bucket-name"
  description = "S3 bucket name fluent-bit should stream logs into."
}

variable "role_name" {
  type        = string
  default     = "logger"
  description = "AWS IAM Role fluent-bit will be using to stream logs."
}
