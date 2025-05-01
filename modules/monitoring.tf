resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/web-app"
  retention_in_days = 7
}

resource "aws_s3_bucket" "trail_bucket" {
  bucket = var.s3_bucket_for_ct
}

resource "aws_cloudtrail" "main" {
  name                          = "web-app-trail"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
}
