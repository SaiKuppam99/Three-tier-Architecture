# Create S3 Bucket Public
# Map to CDN 
resource "aws_s3_bucket" "static_bucket" {
  bucket = var.domain_name
  acl    = "public-read"

  force_destroy = true

  website {
    index_document = "index.html"
  }

  policy = <<-EOT
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "PublicReadGetObject",
              "Effect": "Allow",
              "Principal": "*",
              "Action": [
                  "s3:GetObject"
              ],
              "Resource": [
                  "arn:aws:s3:::${var.domain_name}/*"
              ]
          }
      ]
    }
  EOT
    tags = {
    Name        = "${var.domain_name}"
    Environment = "${var.deployment_stage}" 
  }
}



# Create CloudFront Distribution
# Map to CDN  and S3 and Route53
resource "aws_cloudfront_distribution" "static_bucket_distribution" {
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = aws_s3_bucket.static_bucket.website_endpoint
    origin_id   = "devopsthoughts.com"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "devopsthoughts.com"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # aliases = ["devopsthoughts.com", "dev.devopsthoughts.com"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.static_bucket_certificate.arn}"
    ssl_support_method  = "sni-only"
  }
 
}




resource "aws_acm_certificate" "static_bucket_certificate" {
  domain_name       = "*.devopsthoughts.com"
  validation_method = "DNS"

  tags = {
    name = "Devopsthoughts.com"
  }

  lifecycle {
    create_before_destroy = true
  }
}


data "aws_route53_zone" "zone" {
  name = "devopsthoughts.com"
}



# Cloudfront Mapping with Route53
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "devopsthoughts.com"
  type    = "A"
  # ttl = "5"

  alias  {
    name                   = "${aws_cloudfront_distribution.static_bucket_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.static_bucket_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
