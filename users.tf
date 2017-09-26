data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}

## Create a readonly user
resource "aws_iam_user" "read_only_user" {
  name          = "acp-ro-${var.environment}"
  force_destroy = "${var.allow_teardown}"
}

resource "aws_iam_group" "read_only_group" {
  name = "acp-ro-${var.environment}"
}

resource "aws_iam_group_policy_attachment" "attach_read_only_policy" {
  group      = "${aws_iam_group.read_only_group.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Allow kops access to it's bucket for audit / dry-run
data "aws_iam_policy_document" "cluster_dryrun_policy_doc" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.kops_state_bucket}/*",
    ]
  }
}

# Policy to allow access to audit potential changes to a cluster
resource "aws_iam_policy" "cluster_dryrun_policy" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  name        = "acp-cluster-dryrun-${var.environment}"
  description = "Allow cluster (kops) --dry-run"

  policy = "${data.aws_iam_policy_document.cluster_dryrun_policy_doc.json}"
}

# Assign the cluster '--dry-run' permiisions to the read only user
resource "aws_iam_group_policy_attachment" "attach_kops_bucket_access" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  group      = "${aws_iam_group.read_only_group.name}"
  policy_arn = "${aws_iam_policy.cluster_dryrun_policy.arn}"
}

# Allow access for terraform to create a lock when auditing and decrypt secrets
data "aws_iam_policy_document" "terraform_plan_policy_doc" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.terraform_lock_table}",
    ]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:Get*",
      "kms:List*",
    ]

    resources = [
      "*",
    ]
  }
}

# Policy to allow access to audit potential changes to terraform infra (plan)
resource "aws_iam_policy" "terraform_plan_permissions" {
  count = "${var.terraform_lock_table != "" ? 1 : 0}"

  name        = "acp-terraform-plan-${var.environment}"
  description = "Allow terraform plan"
  policy      = "${data.aws_iam_policy_document.terraform_plan_policy_doc.json}"
}

# Assign access to run terraform plan to the read only user group
resource "aws_iam_group_policy_attachment" "attach_kops_dynamodb_table" {
  count = "${var.terraform_lock_table != "" ? 1 : 0}"

  group      = "${aws_iam_group.read_only_group.name}"
  policy_arn = "${aws_iam_policy.terraform_plan_permissions.arn}"
}

resource "aws_iam_group_membership" "read_only_group_membership" {
  name  = "acp-ro-group-membership-${var.environment}"
  group = "${aws_iam_group.read_only_group.name}"
  users = ["${aws_iam_user.read_only_user.name}"]
}

# Create an admin user
resource "aws_iam_user" "admin_user" {
  name          = "acp-admin-${var.environment}"
  force_destroy = "${var.allow_teardown}"
}

resource "aws_iam_group" "admin_group" {
  name = "acp-admin-${var.environment}"
}

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

resource "aws_iam_group_policy_attachment" "attach_admin_policy" {
  group      = "${aws_iam_group.admin_group.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "admin_group_membership" {
  name  = "acp-admin-group-membership-${var.environment}"
  group = "${aws_iam_group.admin_group.name}"
  users = ["${aws_iam_user.admin_user.name}"]
}

# Create a platform-services user
resource "aws_iam_user" "platform_services_user" {
  name          = "acp-platform-services-${var.environment}"
  force_destroy = "${var.allow_teardown}"
}

resource "aws_iam_group" "platform_services_group" {
  name = "acp-platform-services-${var.environment}"
}

resource "aws_iam_policy" "platform_services_policy" {
  name   = "acp-platform-services-${var.environment}"
  policy = "${data.aws_iam_policy_document.platform_services_policy.json}"
}

resource "aws_iam_group_policy_attachment" "attach_platform_services_policy" {
  group      = "${aws_iam_group.platform_services_group.name}"
  policy_arn = "${aws_iam_policy.platform_services_policy.arn}"
}

resource "aws_iam_group_membership" "platform_services_group_membership" {
  name  = "acp-platform-services-group-membership-${var.environment}"
  group = "${aws_iam_group.platform_services_group.name}"
  users = ["${aws_iam_user.platform_services_user.name}"]
}
