package compliance.policy.aws_cloudtrail.data_adapter

is_trail {
	input.subType == "aws-trail"
}

trail = input.resource.Trail

trail_status = input.resource.Status

trail_bucket_info = input.resource.bucket_info

event_selectors = input.resource.EventSelectors
