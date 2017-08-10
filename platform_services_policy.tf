data "aws_iam_policy_document" "platform_services_policy" {
  statement {
    actions = [
      "rds:*",
      "s3:*",
      "elasticloadbalancing:*",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }
}
