package compliance.policy.aws_cloudtrail.data_adapter

is_monitoring_type {
	input.type == "monitoring"
	input.subType = "aws-trail"
}

trail_items = input.resource.Items

is_securityhub_subType {
	input.subType == "aws-securityhub"
}

securityhub_resource = input.resource
