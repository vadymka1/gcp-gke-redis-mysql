 provider "google" {
    # version = "~> 3.0"
    # credentials = "${file("/home/electropk/Documents/GCP/vadim-fedorenko-internship.json")}"
    # credentials = "${file("~/Desktop/credentails/GCP/vadim-fedorenko-internship.json")}"
    credentials = "${file("~/Desktop/credentails/GCP/new-test.json")}"
    project = "${var.project_name}"
    region  = "${var.region}"
    zone    = "${var.zone}"
 }

 provider "google-beta" {
    # credentials = "${file("/home/electropk/Documents/GCP/vadim-fedorenko-internship.json")}"
    # credentials = "${file("~/Desktop/credentails/GCP/vadim-fedorenko-internship.json")}"
    credentials = "${file("~/Desktop/credentails/GCP/new-test.json")}"
    project     = "${var.project_id}"
    region      = "${var.region}"
    zone        = "${var.zone}"
}

module "vpc" {
    source           = "./modules/vpc"
    project          = "${var.project_id}"
    network          = "${var.network_name}"
    region           = "${var.region}"
    subnetwork       = "${var.subnet_name}"
}

module "cloudsql" {
    source           = "./modules/cloudsql"
    network          = "${var.network_name}"
    private_ip_name  = "${var.private_ip_name}" # Private IP Name
    project          = "${var.project_id}"
    region           = "${var.region}"
    database_version = "${var.mysql_version}"
}

module "gke" {
    source           = "./modules/gke"
    cluster          = "${var.cluster_name}" # Cluster Name
    # network          = "${var.network_name}"
    network          = "${module.vpc.network_name}"
    project       = "${var.project_id}"
    region           = "${var.region}"
    subnetwork       = "${module.vpc.subnet_name}"
    zones            = ["${var.zone}"] # ["us-east1-b", "us-east1-c", "us-east1-d"]

}

# module "memorystore" {
#     source        = "./modules/memorystore"
#     network       = "${module.vpc.network_name}"
#     name          = "${var.redis_db_name}"
#     display_name  = "${var.redis_db_name}"
#     project       = "${var.project_name}"
#     location_id   = "${var.zone}"
#     redis_version = "${var.redis_version}"
#     region        = "${var.region}"
#     size          = "1"
# }

module "redis_db" {
    source         = "terraform-google-modules/memorystore/google"
    version        = "1.0.0"

    name           = "${var.redis_db_name}"
    project        = "${var.project_name}"
    memory_size_gb = "1"
    redis_version = "${var.redis_version}"

    region = "${var.region}"
    # zone   = "${var.zone}"

    authorized_network = "${var.network_name}"
}
