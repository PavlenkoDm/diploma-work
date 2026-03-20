# ==============================
# СЕРВИСНЫЙ АККАУНТ
# ==============================

resource "yandex_iam_service_account" "terraform-sa" {
  name        = "terraform-sa"
  description = "Сервисный аккаунт для управления инфраструктурой через Terraform"
  folder_id   = var.folder_id
}

# ==============================
# ПРАВА СЕРВИСНОГО АККАУНТА
# ==============================

resource "yandex_resourcemanager_folder_iam_member" "terraform-sa-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform-sa.id}"
}

# ==============================
# СТАТИЧЕСКИЙ КЛЮЧ ДОСТУПА
# ==============================

resource "yandex_iam_service_account_static_access_key" "terraform-sa-key" {
  service_account_id = yandex_iam_service_account.terraform-sa.id
  description        = "Статический ключ для доступа к S3 bucket"
}

# ==============================
# S3 BUCKET
# ==============================

resource "yandex_storage_bucket" "terraform-state" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.terraform-sa-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.terraform-sa-key.secret_key

  anonymous_access_flags {
    read        = false
    list        = false
    config_read = false
  }
}