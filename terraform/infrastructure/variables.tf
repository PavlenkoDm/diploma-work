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

