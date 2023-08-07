package compliance.policy.gcp.monitoring.ensure_log_metric_and_alarm_exists

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.in

finding(filter) = result {
	# filter
	data_adapter.is_monitoring_asset

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(is_setup_exists(filter)),
		{"Monitoring": input.resource},
	)
}

is_setup_exists(filter) {
	print("input:", input.resource)
	some log_metric in input.resource.log_metrics
	print("log_metric:", log_metric)
	print("log_metric_filter:", log_metric.resource.data.filter)
	print("input_filter:", filter)
	log_metric.resource.data.filter == filter
	print("metric_type:", log_metric.resource.data.metricDescriptor.type)
	metric_type := log_metric.resource.data.metricDescriptor.type

	some alert in input.resource.alerts
	print("alert:", alert)
	alert.resource.data.enabled == true

	some condition in alert.resource.data.conditions
	print("condition:", condition)
	print("metric.type:", sprintf("metric.type=\"%s\"", [metric_type]))
	print("conditionThreshold.filter:", condition.conditionThreshold.filter)
	condition.conditionThreshold.filter == sprintf("metric.type=\"%s\"", [metric_type])
} else = false
