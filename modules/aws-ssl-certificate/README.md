# How To

Example 1: 
```
module ssl-certificate-auth {
  # source = "git::https://github.com/dasmeta/terraform.git//modules/aws-ssl-certificate?ref=aws-ssl-certificates"
  source = "../../../../dasmeta/terraform/modules/aws-ssl-certificate"

  zone = "mydomain.com"
  domain = "auth"

  providers {
    aws = aws.virginia
  }
}

Example 2: create cert in different region (e.g. Cognito requirement).
```
provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
}

module ssl-certificate-auth {
  # source = "git::https://github.com/dasmeta/terraform.git//modules/aws-ssl-certificate?ref=aws-ssl-certificates"
  source = "../../../../dasmeta/terraform/modules/aws-ssl-certificate"

  zone = "mydomain.com"
  domain = "auth"

  providers {
    aws = aws.virginia
  }
}