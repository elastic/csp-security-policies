package compliance.policy.aws_cloudtrail.pattern

# check that a trail has least one metmetric filter pattern that match to at least one pattern
at_least_one_metric_exists(trail, patterns) {
	some i
	filter := trail.MetricFilters[i]
	some j
	pattern := patterns[j]
	filter.FilterPattern == pattern
} else = false {
	true
}
