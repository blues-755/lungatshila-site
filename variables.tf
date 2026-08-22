variable "domain_name" {
  description = "lungatshila.com domain"
  type = string
  default = "lungatshila.com"
}

variable "include_www" {
  description = "serve/redirect www subdomain from the same distribution"
  type = bool
  default = true
}

variable "aws_region" {
  description = "af-south-1"
  type = string
  default = "af-south-1"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type = string
  default = "lungatshila.com"
}

variable "index_document" {
  description = "Object key served as the site's index / default root object."
  type = string
  default = "index.html"
}

variable "index_html_path" {
  description = "Local path of index.html"
  type = string
  default = "./site/index.html"
}

variable "price_class" {
  description = "PriceClass_100"
  type = string
  default = "PriceClass_100"
}

variable "tags" {
  description = "Tagging is good"
  type = map(string)
  default = {
    Project = "lungatshila-site"
    ManagedBy = "terraform"
    Environment = "production"
  }
}

