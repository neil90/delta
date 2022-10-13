module "storage" {
  source = "./modules/storage"

  bucket_name = var.bucket_name
  region      = var.region
  labels      = var.labels
}

## THIS IS FOR COMPUTE ENGINE
module "processing" {
  source = "./modules/processing"
  count = var.dataproc_deplyoment_type == "compute" ? 1 : 0

  project          = var.project
  credentials_file = var.credentials_file
  public_key_path  = var.public_key_path
  region           = var.region
  zone             = var.zone
  dataproc_workers = var.dataproc_workers
  labels           = var.labels
}
#### End of Dataproc COMPUTE ENGINE DEPLOYMENT

### Serverless
module "serverless" {
  source = "./modules/serverless"
  count  = var.dataproc_deplyoment_type == "serverless" ? 1 : 0
  region = var.region
  labels = var.labels
}