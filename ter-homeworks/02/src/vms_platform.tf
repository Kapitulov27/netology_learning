variable "vm_web_name_prefix" {
  type        = string
  description = "Префикс имени веб-ВМ"
  default     = "netology-develop-platform"
}

variable "vm_web_suffix" {
  type        = string
  description = "Суффикс имени веб-ВМ"
  default     = "web"
}

variable "vm_db_name_prefix" {
  type        = string
  description = "Префикс имени DB-ВМ"
  default     = "netology-develop-platform"
}

variable "vm_db_suffix" {
  type        = string
  description = "Суффикс имени DB-ВМ"
  default     = "db"
}

variable "environment" {
  type        = string
  description = "Имя окружения"
  default     = "develop"
}


variable "vm_web_image_family" {
  type        = string
  description = "Семейство образа ОС"
  default     = "ubuntu-2004-lts"
}


# variable "vm_web_name" {
#   type        = string
#   description = "Имя веб-ВМ"
#   default     = "netology-develop-platform-web"
# }

# variable "vm_web_platform_id" {
#   type        = string
#   description = "Платформа ВМ"
#   default     = "standard-v1"
# }

# variable "vm_web_zone" {
#   type        = string
#   description = "Зона доступности"
#   default     = "ru-central1-a"
# }

# variable "vm_web_cores" {
#   type        = number
#   description = "Количество ядер CPU"
#   default     = 2
# }

# variable "vm_web_memory" {
#   type        = number
#   description = "Объём памяти в ГБ"
#   default     = 2
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   description = "Гарантированная доля CPU (%)"
#   default     = 5
# }

# variable "vm_web_hdd_size" {
#   type        = number
#   description = "Размер диска в ГБ"
#   default     = 10
# }

# variable "vm_web_hdd_type" {
#   type        = string
#   description = "Тип диска"
#   default     = "network-hdd"
# }

# variable "vm_web_preemptible" {
#   type        = bool
#   description = "Прерываемая ВМ"
#   default     = true
# }

# variable "vm_web_nat" {
#   type        = bool
#   description = "NAT для внешнего IP"
#   default     = true
# }

# variable "vm_web_serial_port" {
#   type        = number
#   description = "Включить серийный порт"
#   default     = 1
# }

# --- DB-ВМ: параметры ресурсов ---

# variable "vm_db_name" {
#   type        = string
#   description = "Имя DB-ВМ"
#   default     = "netology-develop-platform-db"
# }

# variable "vm_db_platform_id" {
#   type        = string
#   description = "Платформа ВМ"
#   default     = "standard-v1"
# }

# variable "vm_db_zone" {
#   type        = string
#   description = "Зона доступности"
#   default     = "ru-central1-b"
# }

# variable "vm_db_cores" {
#   type        = number
#   description = "Количество ядер CPU"
#   default     = 2
# }

# variable "vm_db_memory" {
#   type        = number
#   description = "Объём памяти в ГБ"
#   default     = 2
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   description = "Гарантированная доля CPU (%)"
#   default     = 20
# }

# variable "vm_db_hdd_size" {
#   type        = number
#   description = "Размер диска в ГБ"
#   default     = 10
# }

# variable "vm_db_hdd_type" {
#   type        = string
#   description = "Тип диска"
#   default     = "network-ssd"
# }

# variable "vm_db_image_family" {
#   type        = string
#   description = "Семейство образа ОС"
#   default     = "ubuntu-2004-lts"
# }

# variable "vm_db_preemptible" {
#   type        = bool
#   description = "Прерываемая ВМ"
#   default     = true
# }

# variable "vm_db_nat" {
#   type        = bool
#   description = "NAT для внешнего IP"
#   default     = true
# }

# variable "vm_db_serial_port" {
#   type        = number
#   description = "Cерийный порт"
#   default     = 1
# }