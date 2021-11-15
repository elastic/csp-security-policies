package compliance.cis_k8s.rules.cis_1_1_11

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the etcd data directory permissions are set to 700 or more restrictive
finding = result {
	data_adapter.filename == "etcd"
	filemode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(filemode, 7, 0, 0)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"filemode": filemode},
		"rule_name": "Ensure that the etcd data directory permissions are set to 700 or more restrictive",
		"tags": array.concat(cis_k8s.default_tags, ["CIS 1.1.11"]),
	}
}
