package compliance.policy.audit.file.ensure_permissions

import data.compliance.lib.common
import data.compliance.policy.data_adapters.file as data_adapter

finding(user, group, other) := result {
	mode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(mode, user, group, other)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"expected": {"filemode": ((user * 100) + (group * 10)) + other},
		"evidence": {"filemode": mode},
	}
}

path_filter(name) := common.file_in_path(name, data_adapter.file_path)

filename_filter(name) := data_adapter.filename == name

suffix_filter(suffix) := endswith(data_adapter.filename, suffix)
