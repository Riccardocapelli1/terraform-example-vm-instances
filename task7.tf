# task 7
##main.tf
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version = "3.83.0"

  project = var.project_id
  region  = var.region
  zone    = "us-east1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "6.0.0"
  # insert the 3 required variables here
  network_name = "tf-vpc-620528"
  routing_mode = "GLOBAL"
  project_id = "qwiklabs-gcp-01-a89a911df98f"

 subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
        }
 ]
}


#3 ref module bucket storage in main.tf
module "google_storage_bucket" {
 source  = "./modules/storage/"
}

# add storage remote backend
terraform {
 backend "gcs" {
   bucket  = "tf-bucket-846120"
   prefix  = "terraform/state"
 }
}

resource "google_compute_firewall" "default" {
  name    = "tf-firewall"
  network = "tf-vpc-620528"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0", "0.0.0.0/0"]
}
