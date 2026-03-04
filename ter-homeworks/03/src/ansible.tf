resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [for vm in yandex_compute_instance.web : {
      name         = vm.name
      ansible_host = vm.network_interface[0].nat_ip_address
      fqdn         = vm.fqdn
    }]
    databases = [for k, vm in yandex_compute_instance.db : {
      name         = vm.name
      ansible_host = vm.network_interface[0].nat_ip_address
      fqdn         = vm.fqdn
    }]
    storage = [{
      name         = yandex_compute_instance.storage.name
      ansible_host = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn         = yandex_compute_instance.storage.fqdn
    }]
  })

  filename = "${path.module}/inventory.ini"
}