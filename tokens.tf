#
# @NOTE: At the moment we use the token webhook bridge to manage our user tokens, but we need a user to manage
# tokens.csv content; this will be done by the platform hub. This user has to be managed for obvious reasons.
# Hopefully once we've come up with a better implementation we can drop this requirement. Note, the following is
# ONLY done if the module is managing the state bucket
#

# The policy used by the assets user
data "aws_iam_policy_document" "assets_policy" {
  statement {
    actions = ["s3:Get*", "s3:Put*"]

    resources = [
      "arn:aws:s3:::${var.kops_state_bucket}/${var.environment}.${var.dns_zone}-assets/*",
    ]
  }
}

# Policy to allow access to the assets bucket
resource "aws_iam_policy" "assets_policy" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  name        = "acp-assets-${var.environment}"
  description = "Policy to manage the assets for the cluster in environment: ${var.environment}"
  policy      = "${data.aws_iam_policy_document.assets_policy.json}"
}

# This IAM group is to manage permissions for the assets user
resource "aws_iam_group" "assets_users_group" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  name = "acp-assets-${var.environment}"
}

# Attach the policy to the assets group
resource "aws_iam_group_policy_attachment" "attach_assets_policy" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  group      = "${aws_iam_group.assets_users_group.name}"
  policy_arn = "${aws_iam_policy.assets_policy.arn}"
}

# This user is used by the platform hub to manage the assets (tokens really, but i want to be generic)
resource "aws_iam_user" "assets_user" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  name          = "acp-assets-${var.environment}"
  force_destroy = "${var.allow_teardown}"
}

# Attach the above user to asset group
resource "aws_iam_group_membership" "assets_group_membership" {
  count = "${var.kops_state_bucket != "" ? 1 : 0}"

  name  = "acp-assets-group-membership-${var.environment}"
  group = "${aws_iam_group.assets_users_group.name}"
  users = ["${aws_iam_user.assets_user.name}"]
}
