locals {
  application_name = "terraform-sandbox"
  company_name     = "example-company"
  company_domain   = "example-company.com"
  environment_type = "dev"
  common_tags = {
    "${local.company_name}:environment-type" = local.environment_type
    "${local.company_name}:application-name" = local.application_name
  }
}
