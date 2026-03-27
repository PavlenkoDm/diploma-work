# ==============================
# VPC network
# ==============================

resource "yandex_vpc_network" "diploma-network" {
  name      = var.network_name
  folder_id = var.folder_id
}

# ==============================
# SUBNETS in zones
# ==============================

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = var.subnet_v4cidr_blocks.subnet_a
  folder_id      = var.folder_id
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = var.subnet_v4cidr_blocks.subnet_b
  folder_id      = var.folder_id
}

resource "yandex_vpc_subnet" "subnet-d" {
  name           = "subnet-d"
  zone           = var.zone_d
  network_id     = yandex_vpc_network.diploma-network.id
  v4_cidr_blocks = var.subnet_v4cidr_blocks.subnet_d
  folder_id      = var.folder_id
}

# ==============================
# OS Image
# ==============================

data "yandex_compute_image" "ubuntu" {
  family = var.os_image_family
}

# ==============================
# MASTER NODE
# ==============================

resource "yandex_compute_instance" "master" {
  name        = var.vm_master_config.name
  hostname    = var.vm_master_config.name
  platform_id = var.cpu_type
  zone        = var.zone_a
  folder_id   = var.folder_id

  resources {
    cores         = var.vm_master_config.cores
    memory        = var.vm_master_config.memory
    core_fraction = var.vm_master_config.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_master_config.disk_size
      type     = var.vm_master_config.disk_type
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
  name        = "${var.vm_worker_config.name}-${count.index + 1}"
  hostname    = "${var.vm_worker_config.name}-${count.index + 1}"
  platform_id = var.cpu_type
  zone        = count.index == 0 ? var.zone_b : var.zone_d
  folder_id   = var.folder_id

  resources {
    cores         = var.vm_worker_config.cores
    memory        = var.vm_worker_config.memory
    core_fraction = var.vm_worker_config.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_worker_config.disk_size
      type     = var.vm_worker_config.disk_type
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

