module "Production" {
  source = "../../infra"

  repositoryName = "production-ecs"
  aws_region = "us-east-2"
  role_iam = "production"
  profile = "production"
  environment = "production"
  cluster_name = "production"
}

output "IP_alb" {
  value = module.Production.IP
}