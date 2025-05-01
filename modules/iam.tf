# Placeholder for iam module
resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2-s3-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name = "s3AccessPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_s3_access.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2Profile"
  role = aws_iam_role.ec2_s3_access.name
}

output "ec2_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
