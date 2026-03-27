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
  type    = string
  default = ""
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ для доступа к ВМ"
  type      = string
  default   = ""
  sensitive = true
}

variable "sa_name" {
  type    = string
  default = "terraform-sa"
}

variable "sa_role" {
  type    = string
  default = "editor"
}