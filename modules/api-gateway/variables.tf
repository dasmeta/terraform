variable "name" {
  type    = string
  default = "api-gw"
}

variable "create_iam_user" {
  type        = bool
  default     = true
  description = "Whether to create specific api access user to api gateway./[''871]."
}

variable "endpoint_config_type" {
  type    = string
  default = "REGIONAL"
}

variable "stage_name" {
  type    = string
  default = "api-stage"
}

variable "rest_api_id" {
  type    = string
  default = ""
}

variable "open_api_path" {
  type    = string
  default = ""
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key. `pgp_key` is required when `create_iam_user_login_profile` is set to `true`"
  type        = string
  default     = null
}

variable "iam_username" {
  description = "username of newly created IAM user"
  type        = string
  default     = "api-gw-user"
}

variable "policy_name" {
  description = "API Gateway policy name"
  type        = string
  default     = "api-gw-policy"
}

variable "integration_values" {
  type = map(string)
  default = {
    "type"                    = "HTTP" #HTTP AWS MOCK HTTP_PROXY AWS_PROXY
    "endpoint_uri"            = "https://www.google.de"
    "integration_http_method" = "GET"
    "header_name"             = "integration.request.header.x-api-key"
    "header_mapto"            = "method.request.header.x-api-key"
  }
}

variable "method_values" {
  type = map(string)
  default = {
    "http_method"      = "POST"
    authorization      = "NONE"
    "api_key_required" = "true"
  }
}

variable "usage_plan_values" {
  default = {
    usage_plan_name          = "my-usage-plan"
    "usage_plan_description" = "my description"
    "quota_limit"            = 10000
    "quota_period"           = "MONTH"
    "throttle_burst_limit"   = 1000
    "throttle_rate_limit"    = 500
  }
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "method_path" {
  type    = string
  default = "*/*"
}

variable "monitoring_settings" {
  default = {
    "metrics_enabled"        = true
    "data_trace_enabled"     = true
    "logging_level"          = "INFO"
    "throttling_rate_limit"  = 100
    "throttling_burst_limit" = 50
  }
}

variable "create_policy" {
  description = "Whether create a policy or not."
  type        = bool
  default     = true
}

variable "response_models" {
  description = "A map of the API models used for the response's content type."
  type        = map(any)
  default     = null
}
