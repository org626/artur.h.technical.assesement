variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "service_plan_name" {
  type = string
}

variable "service_plan_sku_name" {
  type = string
}

variable linux_web_app_name {
  type = string
}

variable "postgresql_flexible_server_name" {
  type = string
}

variable "postgresql_flexible_server_database_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "frontend_subnet_name" {
  type = string
}

variable "backend_subnet_name" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "private_dns_zone_virtual_network_link_name" {
  type = string
}