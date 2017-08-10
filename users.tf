## Create a readonly user
resource "aws_iam_user" "read_only_user" {
  name = "acp-ro-${var.environment}"
}

resource "aws_iam_group" "read_only_group" {
  name = "acp-ro-${var.environment}"
}

resource "aws_iam_group_policy_attachment" "attach_read_only_policy" {
  group      = "${aws_iam_group.read_only_group.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_membership" "read_only_group_membership" {
  name  = "acp-ro-group-membership-${var.environment}"
  group = "${aws_iam_group.read_only_group.name}"
  users = ["${aws_iam_user.read_only_user.name}"]
}

# Create an admin user
resource "aws_iam_user" "admin_user" {
  name = "acp-admin-${var.environment}"
}

resource "aws_iam_group" "admin_group" {
  name = "acp-admin-${var.environment}"
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
  name = "acp-platform-services-${var.environment}"
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
