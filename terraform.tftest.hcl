mock_provider "aws" {
}

run "default_config_has_internet_network_origin" {
  command = plan

  variables {
    bucket = "my-bucket"
  }

  assert {
    condition     = length(aws_s3_access_point.resource.vpc_configuration) == 0
    error_message = "vpc_id unset should omit the vpc_configuration block, leaving an internet network origin."
  }

  assert {
    condition     = aws_s3_access_point.resource.public_access_block_configuration[0].block_public_acls == true
    error_message = "Public access should be blocked by default."
  }
}

run "vpc_id_adds_vpc_configuration" {
  command = plan

  variables {
    bucket = "my-bucket"
    vpc_id = "vpc-0123456789abcdef0"
  }

  assert {
    condition     = length(aws_s3_access_point.resource.vpc_configuration) == 1
    error_message = "Setting vpc_id should add exactly one vpc_configuration block."
  }

  assert {
    condition     = one(aws_s3_access_point.resource.vpc_configuration).vpc_id == "vpc-0123456789abcdef0"
    error_message = "The vpc_configuration block should use the supplied vpc_id."
  }
}

run "name_generated_when_unset" {
  command = apply

  variables {
    bucket = "my-bucket"
  }

  assert {
    condition     = aws_s3_access_point.resource.name == random_uuid.resource.id
    error_message = "Leaving name unset should fall back to the generated random_uuid."
  }
}

run "name_explicit_overrides_generated" {
  command = plan

  variables {
    bucket = "my-bucket"
    name   = "my-explicit-access-point"
  }

  assert {
    condition     = aws_s3_access_point.resource.name == "my-explicit-access-point"
    error_message = "An explicit name should be used as-is instead of the generated one."
  }
}

run "public_access_block_can_be_relaxed" {
  command = plan

  variables {
    bucket                  = "my-bucket"
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  }

  assert {
    condition     = !aws_s3_access_point.resource.public_access_block_configuration[0].block_public_acls
    error_message = "Public access block settings should pass through as configured, including when relaxed."
  }
}

run "policy_passthrough" {
  command = plan

  variables {
    bucket = "my-bucket"
    policy = jsonencode({ Version = "2012-10-17", Statement = [] })
  }

  assert {
    condition     = aws_s3_access_point.resource.policy == jsonencode({ Version = "2012-10-17", Statement = [] })
    error_message = "An explicit policy should be passed through to the access point."
  }
}

run "readme_with_bucket" {
  command = plan

  variables {
    bucket = "example-bucket"
  }
}
