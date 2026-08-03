output "network_id" {
  value = yandex_vpc_network.diplom.id
}

output "subnet_ids" {
  value = {
    a = yandex_vpc_subnet.subnet_a.id
    b = yandex_vpc_subnet.subnet_b.id
    d = yandex_vpc_subnet.subnet_d.id
  }
}

output "master_ip" {
  value = yandex_compute_instance.master.network_interface.0.nat_ip_address
}

output "worker_ips" {
  value = yandex_compute_instance.worker[*].network_interface.0.nat_ip_address
}
