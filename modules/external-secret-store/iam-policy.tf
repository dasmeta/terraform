# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "secretsmanager:GetResourcePolicy",
#         "secretsmanager:GetSecretValue",
#         "secretsmanager:DescribeSecret",
#         "secretsmanager:ListSecretVersionIds"
#       ],
#       "Resource": [
#         "arn:aws:secretsmanager:us-west-2:111122223333:secret:dev-*",
#       ]
#     }
#   ]
# }
