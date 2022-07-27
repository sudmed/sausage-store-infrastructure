output "vm_ip_addresses" {
  value = [
    for instance in yandex_compute_instance.vm[*] :
    join(" ", [instance.name, instance.hostname, instance.network_interface.0.ip_address, instance.network_interface.0.nat_ip_address])
  ]
}
