variable "cloud_id" {
  description = "ID облака"
  type        = string
}

variable "folder_id" {
  description = "ID каталога (folder)"
  type        = string
}

variable "zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "storage_access_key" {
  description = "Access key для Object Storage"
  type        = string
  sensitive   = true
}

variable "storage_secret_key" {
  description = "Secret key для Object Storage"
  type        = string
  sensitive   = true
}
