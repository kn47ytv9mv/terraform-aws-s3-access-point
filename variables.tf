variable "bucket" {
  default     = null
  description = "Name or ARN of the S3 bucket to associate with this access point."
}

variable "name" {
  default     = null
  description = "The name of the access point. If null, a unique name is generated."
}

variable "vpc_id" {
  default     = null
  description = "The ID of the VPC to restrict access to this access point. If null, the access point has an internet network origin."
}

variable "block_public_acls" {
  default     = true
  description = "Whether Amazon S3 blocks public ACLs for this access point."
}

variable "block_public_policy" {
  default     = true
  description = "Whether Amazon S3 blocks public bucket policies for this access point."
}

variable "ignore_public_acls" {
  default     = true
  description = "Whether Amazon S3 ignores public ACLs for this access point."
}

variable "restrict_public_buckets" {
  default     = true
  description = "Whether Amazon S3 restricts public bucket policies for this access point."
}

variable "policy" {
  default     = null
  description = "JSON policy document for the access point. If null, no policy is attached."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the access point."
}
