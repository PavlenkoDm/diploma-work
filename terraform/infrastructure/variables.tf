variable "token" {
  description = "OAuth токен для доступа к Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "ID облака в Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "ID каталога в Yandex Cloud"
  type        = string
}

variable "default_zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "bucket_name" {
  description = "Имя S3 bucket для хранения Terraform state"
  type        = string
  default = ""
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ для доступа к ВМ"
  type        = string
  default = ""
  sensitive   = true
}

variable "service_account_id" {
  description = "ID сервисного аккаунта для управления S3 bucket"
  type        = string
}

variable "S3_access_key" {
  description = "Публичный ключ доступа для управления S3 bucket"
  type        = string
  sensitive = true
}

variable "S3_secret_key" {
  description = "Приватный ключ доступа для управления S3 bucket"
  type        = string
  sensitive = true
}

variable "network_name" {
  type    = string
  default = "diploma-network"
}

variable "zone_a" {
  type    = string
  default = "ru-central1-a"
}

variable "zone_b" {
  type    = string
  default = "ru-central1-b"
}

variable "zone_d" {
  type    = string
  default = "ru-central1-d"
}

variable "subnet_v4cidr_blocks" {
  type = object({
    subnet_a = list(string)
    subnet_b = list(string)
    subnet_d = list(string)
  })

  default = {
    subnet_a = ["10.0.1.0/24"]
    subnet_b = ["10.0.2.0/24"]
    subnet_d = ["10.0.3.0/24"]
  }
}

variable "os_image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "cpu_type" {
  type    = string
  default = "standard-v3"
}

variable "vm_master_config" {
  type = object({
    name          = string
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string 
  })

  default = {
    name          = "master"
    cores         = 2
    memory        = 4
    core_fraction = 20
    disk_size     = 50
    disk_type     = "network-ssd"
  }
}

variable "vm_worker_config" {
  type = object({
    name          = string
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string 
  })

  default = {
    name          = "worker"
    cores         = 2
    memory        = 4
    core_fraction = 20
    disk_size     = 50
    disk_type     = "network-ssd"
  }
}

