output "service_account_id" {
  description = "ID сервисного аккаунта"
  value       = yandex_iam_service_account.terraform-sa.id
}

output "access_key" {
  description = "Access key для S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform-sa-key.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret key для S3 backend"
  value       = yandex_iam_service_account_static_access_key.terraform-sa-key.secret_key
  sensitive   = true
}

output "bucket_name" {
  description = "Имя созданного S3 bucket"
  value       = yandex_storage_bucket.terraform-state.bucket
}