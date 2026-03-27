# ==============================
# VPC СЕТЬ
# ==============================

resource "yandex_vpc_network" "diploma-network" {
  name      = "diploma-network"
  folder_id = var.folder_id
}

# ==============================
# ПОДСЕТИ В РАЗНЫХ ЗОНАХ
# ==============================

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  folder_id      = var.folder_id
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  folder_id      = var.folder_id
}

resource "yandex_vpc_subnet" "subnet-d" {
  name           = "subnet-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = ["10.0.3.0/24"]
  folder_id      = var.folder_id
}

# ==============================
# ОБРАЗ ОС
# ==============================

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# ==============================
# MASTER NODE
# ==============================

resource "yandex_compute_instance" "master" {
  name        = "master"
  hostname    = "master"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  folder_id   = var.folder_id

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 50
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# ==============================
# WORKER NODES
# ==============================

resource "yandex_compute_instance" "worker" {
  count       = 2
  name        = "worker-${count.index + 1}"
  hostname    = "worker-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = count.index == 0 ? "ru-central1-b" : "ru-central1-d"
  folder_id   = var.folder_id

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 50
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = count.index == 0 ? yandex_vpc_subnet.subnet-b.id : yandex_vpc_subnet.subnet-d.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

