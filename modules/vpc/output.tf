output "network_name" {
  value       = module.vpc.network_name
  # value = "${google_compute_network.vpc.name}"
  description = "The name of the VPC being created"
}

output "subnet_name" {
    value = module.vpc.subnets_names[0]
    # value = "${google_compute_subnetwork.subnet.name}"
}