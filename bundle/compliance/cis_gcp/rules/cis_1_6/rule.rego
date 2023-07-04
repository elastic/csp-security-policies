package compliance.cis_gcp.rules.cis_1_6

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import data.compliance.policy.gcp.kms.ensure_key_rotation as audit

condition {
	role := data_adapter.iam_policy.bindings[i].role
	role != "roles/iam.serviceAccountUser"
	role != "roles/iam.serviceAccountTokenCreator"
} else = false

finding = result {
	# filter
	data_adapter.is_iam

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(condition),
		{"Role:": data_adapter.iam_policy.bindings[i].role},
	)
}
