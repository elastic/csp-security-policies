package compliance.policy.aws_cloudtrail.pattern

# check that a trail has at least one metric filter pattern that matches at least one pattern
at_least_one_metric_exists(trail, patterns) {
	some i
	filter := trail.MetricFilters[i]
	some j
	pattern := patterns[j]
	filter.FilterPattern == pattern
} else = false {
	true
}
