resource "yandex_storage_bucket" "tfstate" {
  bucket     = "diplom-tfstate-${var.folder_id}"
  access_key = var.storage_access_key
  secret_key = var.storage_secret_key

  versioning {
    enabled = true
  }
}
