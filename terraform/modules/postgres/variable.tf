variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "postgres_admin_username" {
  type      = string
  sensitive = true
}

variable "postgres_admin_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}