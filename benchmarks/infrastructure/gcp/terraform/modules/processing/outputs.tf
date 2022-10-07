output "master_node_address" {
  value = data.google_compute_instance.benchmarks_master.network_interface.0.access_config.0.nat_ip
}

output "google_email_user" {
  value = data.google_client_openid_userinfo.me.email
}