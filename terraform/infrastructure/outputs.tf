output "master_external_ip" {
  description = "Внешний IP адрес master ноды"
  value       = yandex_compute_instance.master.network_interface[0].nat_ip_address
}

output "master_internal_ip" {
  description = "Внутренний IP адрес master ноды"
  value       = yandex_compute_instance.master.network_interface[0].ip_address
}

output "workers_external_ip" {
  description = "Внешние IP адреса worker нод"
  value       = yandex_compute_instance.worker[*].network_interface[0].nat_ip_address
}

output "workers_internal_ip" {
  description = "Внутренние IP адреса worker нод"
  value       = yandex_compute_instance.worker[*].network_interface[0].ip_address
}