output "master_node_address" {
  value = (var.dataproc_deplyoment_type == "compute" ? module.processing[0].master_node_address : "")
}

output "google_email_user" {
  value = (var.dataproc_deplyoment_type == "compute" ? module.processing[0].google_email_user : "")
}

output "cloud_bucket" {
  value = module.storage.gcs_bucket
}