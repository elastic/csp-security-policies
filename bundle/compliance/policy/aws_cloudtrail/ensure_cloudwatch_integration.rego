package compliance.policy.aws_cloudtrail.ensure_cloudwatch

import data.compliance.lib.common
import data.compliance.policy.aws_cloudtrail.data_adapter

default ensure_cloudwatch = false

ensure_cloudwatch {
	data_adapter.trail.CloudWatchLogsLogGroupArn != ""
	common.date_within_duration(time.parse_rfc3339_ns(data_adapter.trail_status.LatestcloudwatchLogdDeliveryTime), "24h")
}
