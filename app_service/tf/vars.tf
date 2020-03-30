variable "location" {
  description = "deployment location"
  type        = string
}

variable "environment_name" {
  description = "environment name"
  type        = string
}

variable "vnet_cidr" {
  type        = string
  description = "VPC cidr block. Example: 10.10.0.0/16"
}

variable "instance" {
  description = "instance id"
  type        = string
}

variable "expiry_hours" {
  type        = string
  description = "expiry time in hours"
}

variable "data_source_rg_name" {
  type = string
}

variable "data_source_name" {
  type = string
}

variable "data_source_container_name" {
  type = string
}