data "google_project" "project" {}

resource "google_compute_network" "vpc_network" {
  name = "neil-vpc-network"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/18"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "rules" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  source_ranges = ["10.2.0.0/18"]
  direction = "INGRESS"
  disabled = false

  allow {
    protocol = "all"
  }

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080", "1000-2000"]
#   }

#   source_tags = ["web"]
}

resource "google_dataproc_metastore_service" "this" {
  provider   = google-beta
  service_id = "dataproc-metastore-for-benchmarks"
  network    = "${google_compute_network.vpc_network.id}"
  location   = var.region
  tier       = "ENTERPRISE"
  hive_metastore_config {
    version = "3.1.2"
  }
  labels = var.labels
}

# resource "google_service_networking_connection" "foobar" {
#   network                 = google_compute_network.vpc_network.id
#   service                 = "servicenetworking.googleapis.com"
# }