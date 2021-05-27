# VPC
variable "vpc_name" {
  type = string
  description = "Creating VPC name."
}

variable "cidr" {
  type = string
  # default = "172.16.0.0/16"
  description = "CIDR ip range."
}

variable "availability_zones" {
  type = list(string)
  description = "List of VPC availability zones, e.g. ['eu-west-1a', 'eu-west-1b', 'eu-west-1c']."
}

variable "private_subnets" {
  type = list(string)
  # default = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  description = "Private subnets of VPC."
}

variable "public_subnets" {
  type = list(string)
  # default = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  description = "Public subnets of VPC."
}

variable "public_subnet_tags" {
  type = map
  default = {}
}

variable "private_subnet_tags" {
  type = map
  default = {}
}

# EKS
variable "cluster_name" {
  type = string
  description = "Creating eks cluster name."
}

variable "manage_aws_auth" {
  type = bool
  default = true
}

variable "worker_groups" {
  type = list(object({
    instance_type = string
    asg_max_size  = number
  }))
  default = [
    {
      instance_type = "t3.xlarge"
      asg_max_size  = 5
    }
  ]
  description = "Worker groups."
}

variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "workers_group_defaults" {
  type = object({
    root_volume_type = string
  })
  default = {
    root_volume_type = "gp2"
  }
  description = "Worker group defaults."
}

variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}

# ALB-INGRESS-CONTROLLER

variable "alb_log_bucket_prefix" {
  type = string
  default = ""
}

# FLUENT-BIT
variable "fluent_bit_name" {
  type = string
  default = ""
}

variable "log_group_name" {
  type = string
  default = ""
}

# METRICS-SERVER
variable "enable_metrics_server" {
  type = bool
  default = false
}

variable "metrics_server_name" {
  type = string
  default = "metrics-server"
}
