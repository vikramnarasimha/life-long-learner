# Configure the GCP provider
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 5.0"
        }
    }
}

provider "google" {
    project = var.project_id
    region = var.region
}

#Create a GCS bucket
resource "google_storage_bucket" "my_bucket" {
    name = var.bucket_name
    location = var.region 
    force_destroy = true
    
    uniform_bucket_level_access = true
}