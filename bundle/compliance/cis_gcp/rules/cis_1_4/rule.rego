package compliance.cis_gcp.rules.cis_1_4

import data.compliance.lib.common

import data.compliance.policy.gcp.data_adapter

condition {
	member := data_adapter.iam_policy.bindings[i].members[j]
	not startswith(member, "user:")
} else = false

finding = result {
	data_adapter.is_iam
	result := common.generate_result_without_expected(
		common.calculate_result(condition),
		{"Members": "zz"},
	)
}
