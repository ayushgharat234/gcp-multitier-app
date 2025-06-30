project_id = "gcp-multitier-app"

region = "asia-south1"

vpc_name = "multitier-vpc"

subnets = [
  {
    name                  = "frontend-subnet"
    region                = "asia-south1"
    cidr                  = "10.10.10.0/24"
    private_google_access = false
  },
  {
    name                  = "app-subnet"
    region                = "asia-south1"
    cidr                  = "10.10.20.0/24"
    private_google_access = true
  },
  {
    name                  = "db-subnet"
    region                = "asia-south1"
    cidr                  = "10.10.30.0/24"
    private_google_access = true
  }
]

nat_region = "asia-south1"

allowed_ssh_source_ranges = ["208.67.222.222/32"]

frontend_subnet = "frontend-subnet"

app_subnet = "app-subnet"

machine_type = "e2-medium"