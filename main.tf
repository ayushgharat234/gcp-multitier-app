# Network module: creates VPC, subnets, NAT, and related networking resources
module "network" {
  source     = "./modules/network"
  vpc_name   = var.vpc_name
  subnets    = var.subnets
  nat_region = var.nat_region
}

# Security module: sets up firewall rules and IAM bindings for access control
module "security" {
  source                    = "./modules/security"
  vpc_self_link             = module.network.vpc_self_link
  allowed_ssh_source_ranges = var.allowed_ssh_source_ranges
  project_id                = var.project_id
  allowed_frontend_to_app   = var.allowed_frontend_to_app
  allowed_app_to_db         = var.allowed_app_to_db
  db_port                   = var.db_port
  app_port                  = var.app_port
  enable_cloud_armor        = true
}

# Frontend compute module: deploys managed instance group for frontend tier
module "frontend_compute" {
  source          = "./modules/compute"
  project_id      = var.project_id
  region          = var.region
  instance_prefix = "frontend"
  subnet          = module.network.subnet_self_links["frontend-subnet"]
  machine_type    = var.machine_type
  instance_tags   = ["frontend"]
  startup_script  = file("${path.module}/scripts/startup-frontend.sh")
}

# App compute module: deploys managed instance group for application tier
module "app_compute" {
  source          = "./modules/compute"
  project_id      = var.project_id
  region          = var.region
  instance_prefix = "app"
  subnet          = module.network.subnet_self_links["app-subnet"]
  machine_type    = var.machine_type
  instance_tags   = ["app"]
  startup_script  = file("${path.module}/scripts/startup-app.sh")
}

# Load balancer module: provisions HTTP(S) load balancer for frontend
module "loadbalancer" {
  source                 = "./modules/loadbalancer"
  project_id             = var.project_id
  region                 = var.region
  frontend_mig           = module.frontend_compute.instance_group_self_link
  health_check_self_link = module.frontend_compute.health_check_self_link
}

# DB compute module: deploys managed instance group for database tier
module "db_compute" {
  source          = "./modules/compute"
  project_id      = var.project_id
  region          = var.region
  instance_prefix = "db"
  subnet          = module.network.subnet_self_links["db-subnet"]
  machine_type    = var.machine_type
  instance_tags   = ["db"]
  startup_script  = file("${path.module}/scripts/startup-db.sh")
}
