package compliance.cis_gcp.rules.cis_1_7

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

duration = sprintf("%dh", [90 * 24]) # 90 days converted to hours

finding = result if {
	data_adapter.is_iam_service_account_key

	date := time.parse_rfc3339_ns(data_adapter.resource.data.validAfterTime)

	result := common.generate_result_without_expected(
		common.calculate_result(common.date_within_duration(date, duration)),
		data_adapter.resource.data.validAfterTime,
	)
}
