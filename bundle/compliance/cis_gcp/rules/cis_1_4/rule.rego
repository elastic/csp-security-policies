package compliance.cis_gcp.rules.cis_1_4

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import data.compliance.policy.gcp.kms.ensure_key_rotation as audit

condition {
	member := data_adapter.iam_policy.bindings[i].members[j]
	not startswith(member, "user:")
} else = false

finding = result {
	# filter
	data_adapter.is_iam

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(condition),
		{"Members:": data_adapter.iam_policy.bindings[i].members},
	)
}
