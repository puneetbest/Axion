variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "aks_subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}