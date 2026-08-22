data "aws_route53_zone" "this" {
  name = var.domain_name
  private_zone = false
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

