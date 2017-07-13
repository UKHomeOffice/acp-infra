
# Create cloudtrail logging if bucket is specified
resource "aws_cloudtrail" "cloudtrail" {
  count                         = "${var.cloudtrail_bucket != "" ? 1 : 0}"
  name                          = "${var.environment}-cloudtrail"
  include_global_service_events = true
  s3_bucket_name                = "${var.cloudtrail_bucket}"
  s3_key_prefix                 = "${var.environment}-cloudtrail"

  tags = {
    Name              = "${var.environment}-cloudtrail"
    Env               = "${var.environment}"
    KubernetesCluster = "${var.environment}"
  }
}
