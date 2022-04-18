package compliance.cis_k8s.rules.cis_1_1_2

import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the API server pod specification file ownership is set to root:root
finding = result {
	data_adapter.filename == "kube-apiserver.yaml"
	uid = data_adapter.owner_user_id
	gid = data_adapter.owner_group_id
	rule_evaluation := common.file_ownership_match(uid, gid, "root", "root")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"expected": {"uid": "root", "gid": "root"},
		"evidence": {"uid": uid, "gid": gid},
	}
}
