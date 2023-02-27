package compliance.policy.aws_kms.data_adapter

is_kms {
	input.subType == "aws-kms"
}

key_rotation_enabled := input.resource.KeyRotationEnabled

key_metadata := input.resource.KeyMetadata
