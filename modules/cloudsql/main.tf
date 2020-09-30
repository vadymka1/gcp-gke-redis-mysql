locals {
  network          = join("/", ["projects", var.project, "global", "networks", var.network])
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = var.private_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${var.network_name}"
  depends_on    = [local.network]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = "${var.network_name}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  depends_on              = [local.network]
}

resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name = "${var.mysql_db_name}"
  database_version = "${var.mysql_version}"
  region = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-custom-1-3840"
    ip_configuration {
      ipv4_enabled    = false
      private_network = local.network
    }
  }
}

resource "google_sql_user" "users" {
  name     = var.user_name
  instance = google_sql_database_instance.instance.name
  password = var.user_password
}