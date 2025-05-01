# Placeholder for storage module
resource "aws_s3_bucket" "uploads" {
  bucket = "web-app-uploads-${random_id.rand.hex}"
  force_destroy = true
}

resource "random_id" "rand" {
  byte_length = 4
}

resource "aws_efs_file_system" "shared" {
  tags = { Name = "SharedFS" }
}

resource "aws_efs_mount_target" "efs_mount" {
  file_system_id  = aws_efs_file_system.shared.id
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.uploads.bucket
}

output "efs_id" {
  value = aws_efs_file_system.shared.id
}
