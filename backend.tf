# data "terraform_remote_state" "backend" {
#   backend = "gcs"
#   config = {
#     bucket  = ""
#     prefix  = "terraform"
#     credentials = "${file("/home/electropk/Documents/GCP/vadim-fedorenko-internship.json")}"
#   }
# }