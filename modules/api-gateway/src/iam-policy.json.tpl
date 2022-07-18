{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "apigateway:GET",
      "Resource": [
        "arn:aws:apigateway:${region}::/account",
        "arn:aws:apigateway:${region}::/apis",
        "arn:aws:apigateway:${region}::/restapis",
        "arn:aws:apigateway:${region}::/restapis/${api_gateway_id}",
        "arn:aws:apigateway:${region}::/restapis/${api_gateway_id}/*"
      ]
    },
    {
      "Sid": "VisualEditor4",
      "Effect": "Allow",
      "Action": "apigateway:*",
      "Resource": [
        "arn:aws:apigateway:${region}::/apikeys/*",
        "arn:aws:apigateway:${region}::/apikeys",
        "arn:aws:apigateway:${region}::/usageplans",
        "arn:aws:apigateway:${region}::/usageplans/*"
      ]
    }
  ]
}
