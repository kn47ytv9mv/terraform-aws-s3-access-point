resource "random_uuid" "resource" {}

resource "aws_s3_access_point" "resource" {
  bucket = var.bucket
  name   = coalesce(var.name, random_uuid.resource.id)

  dynamic "vpc_configuration" {
    for_each = var.vpc_id[*]

    content {
      vpc_id = vpc_configuration.value
    }
  }

  public_access_block_configuration {
    block_public_acls       = var.block_public_acls
    block_public_policy     = var.block_public_policy
    ignore_public_acls      = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
  }

  policy = var.policy

  tags = var.tags
}

output "id" {
  description = "The account ID and name of the access point, separated by a colon."
  value       = aws_s3_access_point.resource.id
}

output "arn" {
  description = "The ARN of the access point."
  value       = aws_s3_access_point.resource.arn
}

output "alias" {
  description = "The alias of the access point."
  value       = aws_s3_access_point.resource.alias
}

output "domain_name" {
  description = "The DNS domain name of the access point, in the format needed to access it via HTTPS."
  value       = aws_s3_access_point.resource.domain_name
}
