# Placeholder for database module
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  name                 = "appdb"
  username             = "admin"
  password             = "password123"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name = aws_db_subnet_group.db_subnets.name
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "db-subnets"
  subnet_ids = [var.subnet_id]
}

resource "aws_dynamodb_table" "sessions" {
  name           = "sessions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "session_id"

  attribute {
    name = "session_id"
    type = "S"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "dynamodb_name" {
  value = aws_dynamodb_table.sessions.name
}
