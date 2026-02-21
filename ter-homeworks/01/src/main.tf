terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.120"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

variable "yc_token" {
  type      = string
  sensitive = true
}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-d"
}

resource "yandex_vpc_network" "net" {
  name = "docker-net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "docker-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "vm" {
  name        = "docker-mysql"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8498pb5smsd5ch4gid"
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/omp/.ssh/id_ed25519_kvpn.pub")}"
    user-data = <<-EOF
              #cloud-config
              package_update: true
              packages:
                - docker.io
              runcmd:
                - systemctl enable --now docker
                - usermod -aG docker ubuntu
              EOF
  }
}

resource "random_password" "root" {
  length  = 16
  special = false
}

resource "random_password" "user" {
  length  = 16
  special = false
}

output "vm_ip" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "root_pass" {
  value = random_password.root.result
  sensitive = true
}

output "user_pass" {
  value = random_password.user.result
  sensitive = true
}