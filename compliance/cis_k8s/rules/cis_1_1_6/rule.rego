package compliance.cis.rules.cis_1_1_6

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the scheduler pod specification file ownership is set to root:root (Automated)
finding = result {
	data_adapter.filename == "kube-scheduler.yaml"
	uid = data_adapter.owner_user_id
	gid = data_adapter.owner_group_id
	rule_evaluation := common.file_ownership_match(uid, gid, "root", "root")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"uid": uid, "gid": gid},
		"rule_name": "Ensure that the scheduler pod specification file ownership is set to root:root",
		"tags": array.concat(cis_k8s.default_tags, ["CIS 1.1.6"]),
	}
}
