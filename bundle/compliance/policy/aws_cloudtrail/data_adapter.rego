package compliance.policy.aws_cloudtrail.data_adapter

is_trail {
	input.subType == "aws-trail"
}

trail = input.resource
