resource "google_compute_network" "vpc_network" {
    name                    = var.vpc_name
    auto_create_subnetworks = false 
    routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnets" {
    for_each                 = { for subnet in var.subnets : subnet.name => subnet}
    name                     = each.value.name
    ip_cidr_range            = each.value.cidr 
    region                   = each.value.region
    network                  = google_compute_network.vpc_network.id
    private_ip_google_access = each.value.private_google_access 
    purpose                  = "PRIVATE"
    role                     = "ACTIVE"

    log_config {
        aggregation_interval = "INTERVAL_5_SEC"
        flow_sampling = 0.5
        metadata = "INCLUDE_ALL_METADATA"
    }
}

resource "google_compute_router" "nat_router" {
    name    = "${var.vpc_name}-router"
    region  = var.nat_region
    network = google_compute_network.vpc_network.name
}

resource "google_compute_router_nat" "nat_gateway" {
    name                               = "${var.vpc_name}-nat"
    router                             = google_compute_router.nat_router.name
    region                             = var.nat_region
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    enable_endpoint_independent_mapping = true

    log_config {
        enable = true
        filter = "ALL"
    }
}
