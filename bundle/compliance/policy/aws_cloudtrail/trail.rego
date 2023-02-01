package compliance.policy.aws_cloudtrail.trail

import data.compliance.policy.aws_cloudtrail.data_adapter
import data.compliance.policy.aws_cloudtrail.pattern

at_least_one_trail_satisfied(metric_filter_patterns) {
	some i, j
	trail := data_adapter.trail_items[i]

	# is multi region trail
	trail.TrailInfo.Trail.IsMultiRegionTrail

	# and it is avtive
	trail.TrailInfo.Status.IsLogging

	# and it captures all management events 
	selector := trail.TrailInfo.EventSelector.EventSelectors[j]
	selector.IncludeManagementEvents
	selector.ReadWriteType == "All"

	# and the metric filter pattern is as expected
	pattern.at_least_one_metric_exists(trail, metric_filter_patterns)

	# and it has at least one subscription
	count(trail.Topics) > 0
}
