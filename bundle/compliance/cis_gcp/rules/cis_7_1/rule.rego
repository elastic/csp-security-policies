package compliance.cis_gcp.rules.cis_7_1

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import data.compliance.policy.gcp.kms.ensure_key_rotation as audit

condition {
	member := data_adapter.iam_policy.bindings[i].members[j]
	member != "allUsers"
	member != "allAuthenticatedUsers"
} else = false

finding = result {
	# filter
	data_adapter.is_bigquery

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(condition),
		{"Members:": "zoo"},
	)
}
