terraform {
  backend "s3" {
    bucket  = "oci-terraform-tfstate-bucket"
    key     = "../terraform.tfstate" // bucket file path
    region  = "me-central-1" 
    encrypt = true
  }
}
