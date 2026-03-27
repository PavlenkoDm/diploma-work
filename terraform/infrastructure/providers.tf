terraform {
  required_version = ">=1.8.4"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.161.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    shared_credentials_files = ["~/.aws/credentials"]
  
    profile = "default"
    region = "ru-central1"

    bucket = "pavlenko-nwd-20260303"
    key    = "terraform/infrastructure/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id

  zone = var.default_zone
}