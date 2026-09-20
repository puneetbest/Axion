variable "location" {
  type    = string
  default = "eastus"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "postgres_admin_username" {
  type      = string
  sensitive = true
}

variable "postgres_admin_password" {
  type      = string
  sensitive = true
}