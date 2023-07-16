package compliance.cis_gcp.rules.cis_1_6

import data.compliance.lib.common

import data.compliance.policy.gcp.data_adapter

condition {
	role := data_adapter.iam_policy.bindings[i].role
	role != "roles/iam.serviceAccountUser"
	role != "roles/iam.serviceAccountTokenCreator"
} else = false

finding = result {
	data_adapter.is_iam

	result := common.generate_result_without_expected(
		common.calculate_result(condition),
		{"Role": "kk"},
	)
}
