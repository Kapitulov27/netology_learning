locals {
  vm_web_name        = "${var.vm_web_name_prefix}-${var.environment}-${var.vm_web_suffix}"
  vm_db_name         = "${var.vm_db_name_prefix}-${var.environment}-${var.vm_db_suffix}"
  common_ssh_key     = var.vms_ssh_public_root_key
  common_serial_port = 1
}