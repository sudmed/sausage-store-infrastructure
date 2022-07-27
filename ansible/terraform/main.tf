# Create VM
resource "yandex_compute_instance" "vm" {
  count = 2
  name = "chapter5-lesson2-dmitriy-pashkov-vm${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data          = "${file("./meta.txt")}"
    serial-port-enable = 1
  }
}
