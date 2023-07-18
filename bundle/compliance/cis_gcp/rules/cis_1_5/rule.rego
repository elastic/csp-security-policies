package compliance.cis_gcp.rules.cis_1_5

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.every
import future.keywords.if

default is_valid = false

is_valid if {
	# at least one member that starts with "user:"
	some member
	member = data_adapter.iam_policy.bindings[i].members[_]
	startswith(member, "user:")

	# Ensure the role is not a service account managed by Google (iam.gserviceaccount.com suffix).
	role := data_adapter.iam_policy.bindings[i].role
	not endswith(role, "iam.gserviceaccount.com")

	# Confirm the role is not editor/owner
	role != "roles/editor"
	role != "roles/owner"
}

finding = result if {
	data_adapter.is_iam
	data_adapter.has_policy

	result := common.generate_result_without_expected(
		common.calculate_result(is_valid),
		data_adapter.iam_policy,
	)
}
