output "network_name" {
  value = google_compute_network.network.self_link
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnetwork.self_link
}

output "network" {
  value = google_compute_network.network
}

output "subnetwork" {
  value = google_compute_subnetwork.subnetwork
}