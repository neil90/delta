output "gcs_bucket" {
  value = google_storage_bucket.benchmarks_data.name
}