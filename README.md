
# Web App Infrastructure on AWS (Terraform)

This project provides a modular Terraform setup to deploy a scalable web application architecture on AWS, including:

- VPC, Subnets, IGW, NAT Gateway
- EC2 with EBS and IAM Role
- RDS and DynamoDB
- S3, EFS
- IAM Roles and Policies
- CloudWatch and CloudTrail

## Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── compute/
    ├── database/
    ├── iam/
    ├── monitoring/
    ├── networking/
    ├── security/
    └── storage/
```

Each module contains its respective resource definitions.
