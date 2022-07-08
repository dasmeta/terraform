data "aws_region" "current" {}

resource "aws_iam_user" "api-gw-user" {
  count = var.create_user ? 1 : 0

  name = var.iam_username
}

resource "aws_iam_access_key" "api-gw-ak" {
  count = var.create_user ? 1 : 0

  user    = aws_iam_user.api-gw-user[0].name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy" "api-gw-policy" {
  count = var.create_user ? 1 : 0

  name = var.policy_name
  user = aws_iam_user.api-gw-user[0].name

  policy = templatefile("${path.module}/src/iam-policy.json.tpl", {
    count        = var.create_user ? 1 : 0
    restapi_name = aws_api_gateway_rest_api.api-gateway.id
    region       = data.aws_region.current.name
  })
}
