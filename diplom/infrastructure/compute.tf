data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "master" {
  name        = "k8s-master"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker" {
  count       = 2
  name        = "k8s-worker-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.k8s_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
