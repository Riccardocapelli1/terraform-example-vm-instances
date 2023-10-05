# task 1
##main.tf
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version = "3.5.0"

  project = var.project_id
  region  = var.region
  zone    = "us-east1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

## 2 
# instances.tf uncomment to use to accomplish import of modules in instances in task 1 
### tf1
#resource "google_compute_instance" "tf-instance-1" {
#  name         = "tf-instance-1"
#  machine_type = "e2-medium"
#  zone         = "us-east1-c"
#
#  boot_disk {
#    initialize_params {
#      image = "debian-cloud/debian-10"
#    }
#  }
#
#  // Local SSD disk
#  // scratch_disk {
#  //   interface = "SCSI"
#  // }
#
#  network_interface {
#    network = "default"
#
#    access_config {
#      // Ephemeral public IP
#    }
#  }
#
#  metadata_startup_script = <<-EOT
#          #!/bin/bash
#      EOT
#  allow_stopping_for_update = true
#
#}
#
##tf2
#resource "google_compute_instance" "tf-instance-2" {
#  name         = "tf-instance-2"
#  machine_type = "e2-medium"
#  zone         = "us-east1-c"
#
#
#  boot_disk {
#    initialize_params {
#      image = "debian-cloud/debian-10"
#    }
#  }
#
#  // Local SSD disk
#  //scratch_disk {
#  //  interface = "SCSI"
#  //}
#
#  network_interface {
#    network = "default"
#
#    access_config {
#      // Ephemeral public IP
#    }
#  }
#
#  metadata_startup_script = <<-EOT
#        #!/bin/bash
#    EOT
#  allow_stopping_for_update = true
#
#}

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