package compliance.policy.aws_config.data_adapter

is_config {
	input.subType == "aws-config"
}

recorders := input.resource.recorders
