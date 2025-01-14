locals {
  targets                        = var.targets
  origins                        = var.origins
  use_default_cert               = var.use_default_cert
  create_lambda_security_headers = var.create_lambda_security_headers

  viewer_certificates = [
    {
      acm_certificate_arn            = local.use_default_cert ? null : var.acm_cert_arn
      minimum_protocol_version       = local.use_default_cert ? null : "TLSv1.2_2021"
      ssl_support_method             = local.use_default_cert ? null : "sni-only"
      cloudfront_default_certificate = local.use_default_cert
    },
  ]
}

resource "aws_cloudfront_distribution" "main" {
  aliases             = var.domain_names
  comment             = var.comment
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  price_class         = var.price_class
  retain_on_delete    = var.retain_on_delete
  default_root_object = var.default_root_object

  dynamic "custom_error_response" {
    for_each = var.custom_error_response.enabled ? [1] : []
    content {
      error_caching_min_ttl = var.custom_error_response.error_caching_min_ttl
      error_code            = var.custom_error_response.error_code
      response_code         = var.custom_error_response.response_code
      response_page_path    = var.custom_error_response.response_page_path
    }
  }

  tags = {
    Name = var.tags_name
  }

  dynamic "logging_config" {
    for_each = var.logging_config.enabled ? [1] : []
    content {
      bucket          = var.logging_config.bucket
      prefix          = var.logging_config.prefix
      include_cookies = var.logging_config.include_cookies
    }
  }

  wait_for_deployment = var.wait_for_deployment

  default_cache_behavior {
    allowed_methods = var.default_allowed_methods
    cached_methods  = var.default_cached_methods
    compress        = var.default_compress
    default_ttl     = var.default_default_ttl
    cache_policy_id = var.cache_policy_id

    dynamic "forwarded_values" {
      for_each = var.cache_policy_id == "" ? [var.forwarded_values] : []

      content {
        query_string = forwarded_values.value.query_string
        headers      = forwarded_values.value.headers

        cookies {
          forward = forwarded_values.value.forward
        }
      }
    }

    max_ttl                    = var.default_max_ttl
    min_ttl                    = var.default_min_ttl
    smooth_streaming           = var.default_smooth_streaming
    target_origin_id           = var.default_target_origin_id
    response_headers_policy_id = var.create_response_headers_policy.enabled ? module.aws-cloudfront-security-headers-policy[0].id : null
    viewer_protocol_policy     = var.default_viewer_protocol_policy

    dynamic "lambda_function_association" {
      for_each = module.aws-cloudfront-security-headers

      content {
        event_type   = "viewer-response"
        lambda_arn   = module.aws-cloudfront-security-headers[0].lambda_arn
        include_body = var.lambda_function_body
      }
    }

    dynamic "function_association" {
      for_each = var.function_associations

      content {
        event_type   = function_association.value.event_type
        function_arn = function_association.value.function_arn
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = local.targets

    content {
      allowed_methods = var.ordered_allowed_methods
      cached_methods  = var.ordered_cached_methods
      compress        = var.ordered_compress
      default_ttl     = var.ordered_default_ttl
      max_ttl         = var.ordered_max_ttl
      cache_policy_id = var.cache_policy_id

      dynamic "forwarded_values" {
        for_each = var.cache_policy_id == "" ? [var.forwarded_values] : []

        content {
          query_string = forwarded_values.value.query_string
          headers      = forwarded_values.value.headers

          cookies {
            forward = forwarded_values.value.forward
          }
        }
      }

      min_ttl                    = var.ordered_min_ttl
      path_pattern               = ordered_cache_behavior.value.pattern
      smooth_streaming           = var.ordered_smooth_streaming
      target_origin_id           = ordered_cache_behavior.value.target
      viewer_protocol_policy     = var.ordered_viewer_protocol_policy
      response_headers_policy_id = var.create_response_headers_policy.enabled ? module.aws-cloudfront-security-headers-policy[0].id : null
      dynamic "function_association" {
        for_each = var.function_associations

        content {
          event_type   = function_association.value.event_type
          function_arn = function_association.value.function_arn
        }
      }
    }
  }

  dynamic "origin" {
    for_each = local.origins

    content {
      connection_attempts      = var.connection_attempts
      connection_timeout       = var.connection_timeout
      domain_name              = try(origin.value.domain_name, origin.value.target)
      origin_id                = try(origin.value.origin_id, origin.value.target)
      origin_path              = lookup(origin.value, "origin_path", "")
      origin_access_control_id = lookup(origin.value, "origin_access_control_id", null)

      dynamic "custom_origin_config" {
        for_each = origin.value.custom_origin_config

        content {
          http_port                = custom_origin_config.value.http_port
          https_port               = custom_origin_config.value.https_port
          origin_keepalive_timeout = custom_origin_config.value.origin_keepalive_timeout
          origin_protocol_policy   = custom_origin_config.value.origin_protocol_policy
          origin_read_timeout      = custom_origin_config.value.origin_read_timeout
          origin_ssl_protocols     = custom_origin_config.value.origin_ssl_protocols
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
    }
  }

  dynamic "viewer_certificate" {
    for_each = local.viewer_certificates

    content {
      acm_certificate_arn            = viewer_certificate.value.acm_certificate_arn
      minimum_protocol_version       = viewer_certificate.value.minimum_protocol_version
      ssl_support_method             = viewer_certificate.value.ssl_support_method
      cloudfront_default_certificate = viewer_certificate.value.cloudfront_default_certificate
    }
  }
}
