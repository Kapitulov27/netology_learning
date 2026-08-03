terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "diplom-tfstate-b1g5dqlo6qur18m9eq8b"
    region     = "ru-central1"
    key        = "infrastructure/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }
}
