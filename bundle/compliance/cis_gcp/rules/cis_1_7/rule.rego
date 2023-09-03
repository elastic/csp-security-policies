package compliance.cis_gcp.rules.cis_1_7

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

duration = sprintf("%dh", [90 * 24]) # 90 days converted to hours

finding = result if {
	common.is_gcp_subtype("gcp-iam-service-account-key")

	result := common.generate_result_without_expected(
		common.calculate_result(key_created_within_last_90_days),
		data_adapter.resource.data.validAfterTime,
	)
}

key_created_within_last_90_days if {
	date := time.parse_rfc3339_ns(data_adapter.resource.data.validAfterTime)
	common.date_within_duration(date, duration)
} else = false
