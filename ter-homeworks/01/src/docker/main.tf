terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0"
    }
  }
}

variable "vm_ip" {
  type = string
}

variable "root_pass" {
  type      = string
  sensitive = true
}

variable "user_pass" {
  type      = string
  sensitive = true
}

provider "docker" {
  host = "ssh://ubuntu@${var.vm_ip}:22"
  ssh_opts = [
    "-o", "StrictHostKeyChecking=no",
    "-o", "UserKnownHostsFile=/dev/null",
    "-i", "/home/omp/.ssh/id_ed25519_kvpn"
  ]
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  name    = "mysql"
  image   = docker_image.mysql.name
  restart = "always"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${var.root_pass}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${var.user_pass}",
    "MYSQL_ROOT_HOST=%"
  ]
}