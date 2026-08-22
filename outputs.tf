output "site_url" {
  value = "https://${var.domain_name}"
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.site.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.site.id
}

output "acm_certificate_arn" {
  value = aws_acm_certificate_validation.site.certificate_arn
}

output "route53_zone_id" {
  value = data.aws_route53_zone.this.zone_id
}