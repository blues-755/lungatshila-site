resource "aws_cloudfront_origin_access_control" "site" {

  name = "${var.bucket_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"

}

resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.index_document
  price_class         = var.price_class
  aliases             = var.include_www ? [var.domain_name, "www.${var.domain_name}"] : [var.domain_name]
  comment             = "Static site — ${var.domain_name}"

  origin {
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id                = "s3-${var.bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-${var.bucket_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods          = ["GET", "HEAD"]
    compress                = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
  }

  # Single-page placeholder: send 403/404 back to index.html rather than
  # showing a raw S3 XML error. Harmless once the real site replaces this.

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/${var.index_document}"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/${var.index_document}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.site.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

