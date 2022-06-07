package compliance.cis_k8s.rules.cis_1_1_21

import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the Kubernetes PKI key file permissions are set to 600 (Manual)
finding = result {
	common.file_match_pattern("/etc/kubernetes/pki/[a-zA-Z]+.key", data_adapter.file_path)
	filemode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(filemode, 6, 0, 0)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"expected": {"filemode": "644"},
		"evidence": {"filemode": filemode},
	}
}
