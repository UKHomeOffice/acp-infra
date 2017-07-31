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
