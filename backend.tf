terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    # Configuration partielle : valeurs injectées via terraform init
  }
}
