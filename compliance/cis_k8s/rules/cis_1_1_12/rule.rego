package compliance.cis_k8s.rules.cis_1_1_12

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the etcd data directory ownership is set to etcd:etcd
finding = result {
	data_adapter.filename == "etcd"
	uid = data_adapter.owner_user_id
	gid = data_adapter.owner_group_id
	rule_evaluation := common.file_ownership_match(uid, gid, "etcd", "etcd")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"uid": uid, "gid": gid},
		"rule_name": "Ensure that the etcd data directory ownership is set to etcd:etcd",
		"tags": array.concat(cis_k8s.default_tags, ["CIS 1.1.12"]),
	}
}
