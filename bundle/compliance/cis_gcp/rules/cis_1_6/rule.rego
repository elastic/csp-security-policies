package compliance.cis_gcp.rules.cis_1_6

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

default is_valid = false

is_valid if {
	role := data_adapter.iam_policy.bindings[i].role
	role != "roles/iam.serviceAccountUser"
	role != "roles/iam.serviceAccountTokenCreator"
}

finding = result if {
	data_adapter.is_iam
	data_adapter.has_policy

	result := common.generate_result_without_expected(
		common.calculate_result(is_valid),
		data_adapter.iam_policy,
	)
}
