package compliance.cis_k8s.rules.cis_1_1_2

import data.compliance.cis_k8s
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
		"evidence": {"uid": uid, "gid": gid},
		"remediation": sprintf("chown root:root %s", [data_adapter.file_path]),
	}
}

metadata = {
	"name": "Ensure that the API server pod specification file ownership is set to root:root",
	"description": "The API server pod specification file controls various parameters that set the behavior of the API server. You should set its file ownership to maintain the integrity of the file. The file should be owned by root:root.",
	"impact": "None",
	"version": "Version 6",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.1.2", "Master Node Configuration"]),
	"benchmark": "CIS Kubernetes",
}
