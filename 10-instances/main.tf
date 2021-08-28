// Bastion Host
locals {
  hostname = format("%s-bastion", var.vpc_name)
}

// Dedicated service account for the Bastion instance
resource "google_service_account" "bastion" {
  account_id   = format("%s-bastion-sa", var.vpc_name)
  display_name = "GKE Bastion SA"
}

// Allow access to the Bastion Host via SSH
resource "google_compute_firewall" "bastion-ssh" {
  name          = format("%s-bastion-ssh", var.vpc_name)
  network       = google_compute_network.network.name
  direction     = "INGRESS"
  project       = var.project
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["bastion"]
}

// The user-data script on Bastion instance provisioning
data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt-get update -y
  sudo apt-get install -y tinyproxy
  EOF

}

// The Bastion Host
resource "google_compute_instance" "bastion" {
  name = local.hostname
  machine_type = "g1-small"
  zone = var.zone
  project = var.project
  tags = ["bastion"]

  // Specify the Operating System Family and version.
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  // Ensure that when the bastion host is booted, it will have tinyproxy
  metadata_startup_script = data.template_file.startup_script.rendered

  // Define a network interface in the correct subnet.
  network_interface {
    // subnetwork = google_compute_subnetwork.subnetwork.name
    subnetwork = data.terraform_remote_state.network.subnetwork_name
    // Add an ephemeral external IP.
    access_config {
      // Ephemeral IP
    }
  }

  // Allow the instance to be stopped by terraform when updating configuration
  allow_stopping_for_update = true

  service_account {
    email = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }

  // local-exec providers may run before the host has fully initialized. However, they
  // are run sequentially in the order they were defined.
  //
  // This provider is used to block the subsequent providers until the instance
  // is available.
  provisioner "local-exec" {
    command = <<EOF
        READY=""
        for i in $(seq 1 20); do
          if gcloud compute ssh ${local.hostname} --project ${var.project} --zone ${var.zone} --command uptime; then
            READY="yes"
            break;
          fi
          echo "Waiting for ${local.hostname} to initialize..."
          sleep 10;
        done
        if [[ -z $READY ]]; then
          echo "${local.hostname} failed to start in time."
          echo "Please verify that the instance starts and then re-run `terraform apply`"
          exit 1
        fi
EOF
  }
}