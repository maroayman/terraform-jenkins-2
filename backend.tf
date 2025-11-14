terraform {
  backend "s3" {
    bucket       = "git-bucket-s3-24-2-4-24"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

