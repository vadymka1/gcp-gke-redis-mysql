resource "google_compute_firewall" "dev-firewall-rule" {
    name = "${var.name}"
    network = "${var.network_name}"

    allow {
        protocol = "tcp"
        ports = ["22"]
    }
} 