resource "yandex_vpc_network" "diplom" {
  name = "diplom-network"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "diplom-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "diplom-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_vpc_subnet" "subnet_d" {
  name           = "diplom-subnet-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.3.0.0/24"]
}
