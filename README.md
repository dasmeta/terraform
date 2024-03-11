# Why
Somehow AWS does not have same tooling out of the box compared to GCP.
Automate creation of Terraform README documentation and format modules before commit to github repo.

## How
Modules to quickly spin up fully functional eks setup with right subnets and alb/logging/metrics and co.
Using terraform-docs and terraform fmt and pre-commit hooks

# NOTE
## WE have some updates in this module

This modules now are separated in other repositories below are the links of that modules.

1. aws-load-balancer-controller -> https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/aws-load-balancer-controller
2. cloudwatch-metrics -> https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/cloudwatch-metrics
3. eks ->  https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/eks
4. external-secrets -> https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/external-secrets
5. fluent-bit -> https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/fluent-bit
6. metrics-server ->  https://github.com/dasmeta/terraform-aws-eks/tree/main/modules/metrics-server
7. rabbitmq -> https://github.com/dasmeta/terraform-aws-rabbitmq
8. rds ->  https://github.com/dasmeta/terraform-aws-rds
9. complete-eks-cluster -> https://github.com/dasmeta/terraform-aws-eks
10. cloudwatch-log-metric -> https://github.com/dasmeta/terraform-aws-monitoring/tree/main/modules/cloudwatch-log-based-metrics
10. module source: dasmeta/modules/aws//modules/route53 -> dasmeta/dns/aws//modules/route53
    code sources: ./modules/route53 -> https://github.com/dasmeta/terraform-aws-dns/tree/main/modules/route53
11. module source: dasmeta/modules/aws//modules/s3 -> dasmeta/s3/aws
    code sources: ./modules/s3 -> https://github.com/dasmeta/terraform-aws-s3/

## Requirements for pre-commit hooks
for Run our pre-commit hooks you need to install
	- terraform
	- terraform-docs
	- pre-commit

## Config for GitHooks

```bash
git config core.hooksPath githooks
```
## NOTE you must install

```bash
npm install --global git-conventional-commits
```
## What
- alb-ingress-controller with access logs and necessary permissions to handle k8s ingress resource
- eks-metrics-to-cloudwatch-metrics
- eks-logs-to-cloudwatch
- aws-rds-postgres
- terraform-docs
- terraform fmt
- pre-commit hooks

## Comming soon
- cert-manager to request certificates via AWS
