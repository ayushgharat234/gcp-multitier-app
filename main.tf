module "network" {
    source = "./modules/network"
    vpc_name = var.vpc_name
    subnets = var.subnets
    nat_region = var.nat_region
}

module "security" {
    source = "./modules/security"
    vpc_name = var.vpc_name
    allowed_ssh_source_ranges = var.allowed_ssh_source_ranges
    project_id = var.project_id
}

module "frontend_compute" {
    source          = "./modules/compute"
    project_id      = var.project_id
    region          = var.region
    instance_prefix = "frontend"
    subnet          = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.frontend_subnet}"
    machine_type    = var.machine_type
    instance_tags   = ["frontend"]
    startup_script  = file("${path.module}/scripts/startup-frontend.sh")
}

module "app_compute" {
    source = "./modules/compute"
    project_id = var.project_id
    region = var.region
    instance_prefix = "app"
    subnet = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.app_subnet}"
    machine_type = var.machine_type
    instance_tags = ["app"]
    startup_script = file("${path.module}/scripts/startup-app.sh")
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
    project_id = var.project_id
    region = var.region
    frontend_mig = module.frontend_compute.instance_group_name
    health_check_self_link = module.frontend_compute.health_check_self_link
}
