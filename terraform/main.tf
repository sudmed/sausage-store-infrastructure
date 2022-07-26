# Add cloud provider Yandex.Cloud
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = var.IAM_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

# Create VM
resource "yandex_compute_instance" "vm-1" {
  name = "chapter5-lesson2-dmitriy-pashkov-vm-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80qm01ah03dkqb14lc"
    }
  }

  network_interface {
    subnet_id = "e9bq7u62i4q21jq25n5j"
    nat       = true
  }

  metadata = {
    user-data          = "${file("./meta.txt")}"
    serial-port-enable = 1
  }
}

# Get internal IP
output "internal_ip_address" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

# Get external IP
output "external_ip_address" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
