variable "name" {
  type        = string
  description = "Name CloudTrail"
}

variable "enable_log_file_validation" {
  type        = bool
  default     = true
  description = "Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs"
}

variable "is_multi_region_trail" {
  type        = bool
  default     = true
  description = "Specifies whether the trail is created in the current region or in all regions"
}

variable "include_global_service_events" {
  type        = bool
  default     = true
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
}

variable "enable_logging" {
  type        = bool
  default     = true
  description = "Enable logging for the trail"
}

variable "enable_cloudwatch_logs" {
  type        = bool
  default     = false
  description = "Enable sending logs to CloudWatch"
}

variable "cloud_watch_logs_role_arn" {
  type        = string
  description = "Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group"
  default     = ""
}

variable "cloud_watch_logs_group_arn" {
  type        = string
  description = "Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered"
  default     = ""
}

variable "cloud_watch_logs_group_name" {
  type        = string
  description = "Specifies a log group name that will be created to which CloudTrail logs will be delivered"
  default     = "aws-cloudtrail-logs"
}

variable "event_selector" {
  type = list(object({
    include_management_events = bool
    read_write_type           = string

    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))

  description = "Specifies an event selector for enabling data event logging. See: https://www.terraform.io/docs/providers/aws/r/cloudtrail.html for details on this variable"
  default     = []
}

variable "insight_selectors" {
  type        = list(string)
  default     = []
  description = "Configuration block for identifying unusual operational activity."
}

variable "is_organization_trail" {
  type        = bool
  default     = false
  description = "The trail is an AWS Organizations trail"
}

variable "sns_topic_name" {
  type        = string
  description = "Specifies the name of the Amazon SNS topic defined for notification of log file delivery"
  default     = null
}

variable "create_s3_bucket" {
  type    = bool
  default = true
}

variable "bucket_name" {
  type    = string
  default = null
}

variable "s3_key_prefix" {
  type    = string
  default = "cloudtrail"
}

variable "cloudtrail_assume_role_policy_document" {
  type        = string
  description = "Assume role policy document."
  default     = <<-EOF
   {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
   }
  EOF
}

variable "cmdb_integration" {
  type = object({
    enabled = optional(bool, true)
    config = optional(object({
      subscriptions = optional(list(object({
        protocol               = optional(string, null)
        endpoint               = optional(string, null)
        endpoint_auto_confirms = optional(bool, false)
      dead_letter_queue_arn = optional(string) })), [])
    }), {})
  })
  default     = {}
  description = "CMDB Integration Configs"
}

variable "alerts" {
  type = object({
    sns_topic_name = optional(string, "alerts-sns-topic")
    events         = optional(list(string), []) # Some possible values are: iam-user-creation-or-deletion, iam-role-creation-or-deletion, iam-policy-changes, s3-creation-or-deletion, root-account-usage, elastic-ip-association-and-disassociation and etc.
  })
  default     = { enabled : false }
  description = "Provide CloudWatch Log Metric filters"
}
