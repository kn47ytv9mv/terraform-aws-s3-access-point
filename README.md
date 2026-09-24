# terraform-aws-s3-access-point

Terraform module for an S3 Access Point with public access blocked out of
the box, optional VPC-only network origin, and an optional access point
policy.

## Cost

S3 Access Points carry no charge beyond the standard S3 storage and
request pricing of the bucket they front. This module has no cost
impact of its own.

## Usage

```hcl
module "access_point" {
  source = "kn47ytv9mv/s3-access-point/aws"

  bucket = module.bucket.bucket
}
```

Or directly from this repository:

```hcl
module "access_point" {
  source = "github.com/kn47ytv9mv/terraform-aws-s3-access-point"

  bucket = module.bucket.bucket
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| bucket | Name or ARN of the S3 bucket to associate with this access point. | `null` | no |
| name | The name of the access point. If null, a unique name is generated. | `null` | no |
| vpc_id | The ID of the VPC to restrict access to this access point. If null, the access point has an internet network origin. | `null` | no |
| block_public_acls | Whether Amazon S3 blocks public ACLs for this access point. | `true` | no |
| block_public_policy | Whether Amazon S3 blocks public bucket policies for this access point. | `true` | no |
| ignore_public_acls | Whether Amazon S3 ignores public ACLs for this access point. | `true` | no |
| restrict_public_buckets | Whether Amazon S3 restricts public bucket policies for this access point. | `true` | no |
| policy | JSON policy document for the access point. If null, no policy is attached. | `null` | no |
| tags | A map of tags to assign to the access point. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The account ID and name of the access point, separated by a colon. |
| arn | The ARN of the access point. |
| alias | The alias of the access point. |
| domain_name | The DNS domain name of the access point, in the format needed to access it via HTTPS. |

## License

MIT — see [LICENSE.md](LICENSE.md).
