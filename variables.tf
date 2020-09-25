variable "project_name" {
    default     = "vadim-fedorenko-internship"
}

variable "region" {
    default     = "us-central1"
}

variable "zone" {
    default     = "us-central1-c"
}

variable "project_id" {
    default     = "vadim-fedorenko-internship"
}

variable "network_name" {
    default     = "dev-vpc"
}

variable "private_ip_name" {
    default     = "private-ip"
}

variable "subnet_name" {
    default = "dev-subnet"
}

variable "cluster_name" {
    default = "dev-cluster"
}

variable "redis_db_name" {
    default = "dev-redis"
}

variable "redis_version" {
    default = "REDIS_4_0"
}

variable "mysql_version" {
    default = "MYSQL_5_7"
}



variable "node_machine_type" {
    default = "g1-small"
}

variable "node_pool_name" {
    default = "dev-node-pool"
}