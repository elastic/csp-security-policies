package compliance.policy.aws_cloudtrail.data_adapter

is_monitoring_type {
	input.type == "monitoring"
}

trail_items = input.resource.Items
