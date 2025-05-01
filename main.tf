
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "storage" {
  source = "./modules/storage"
}

module "compute" {
  source        = "./modules/compute"
  subnet_id     = module.networking.public_subnet_id
  sg_id         = module.security.sg_id
  iam_instance_profile = module.iam.ec2_profile_name
}

module "database" {
  source    = "./modules/database"
  subnet_id = module.networking.public_subnet_id
  sg_id     = module.security.sg_id
}

module "iam" {
  source = "./modules/iam"
}

module "monitoring" {
  source            = "./modules/monitoring"
  s3_bucket_for_ct  = module.storage.ct_bucket_name
}

output "ec2_public_ip" {
  value = module.compute.ec2_public_ip
}
