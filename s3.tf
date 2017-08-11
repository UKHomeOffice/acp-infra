# The kops state bucket
resource "aws_s3_bucket" "kops_bucket" {
  count  = "${var.kops_state_bucket != "" ? 1 : 0}"
  bucket = "${var.kops_state_bucket}"
  acl    = "private"

  tags = "${merge(var.tags,
    map("Name", format("%s.%s", var.environment, var.dns_zone)),
    map("Env", var.environment, "Role", "kops-bucket"))}"

  force_destroy = "${var.allow_teardown}"

  versioning {
    enabled = true
  }
}
