resource "google_compute_network" "vpc_network" {
  name                    = "web-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "web-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_http_ssh" {
  name    = "allow-http-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["152.165.19.177/32"]

  target_tags = ["http-server"]
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/rocky-linux-cloud/global/images/family/rocky-linux-9"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {
      # 外部IP付与
    }
  }

  metadata = {
    ssh-keys = "rocky:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["http-server"]
}
