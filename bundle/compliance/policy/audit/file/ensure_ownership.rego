package compliance.policy.audit.file.ensure_ownership

import data.compliance.lib.common
import data.compliance.policy.data_adapters.file as data_adapter

finding(owner_user, owner_group) = result {
	user = data_adapter.owner_user
	group = data_adapter.owner_group
	rule_evaluation := common.file_ownership_match(user, group, owner_user, owner_group)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"expected": {"owner": owner_user, "group": owner_group},
		"evidence": {"owner": user, "group": group},
	}
}

path_filter(name) := common.file_in_path(name, data_adapter.file_path)

filename_filter(name) := data_adapter.filename == name
