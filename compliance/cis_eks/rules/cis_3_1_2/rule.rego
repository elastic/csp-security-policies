package compliance.cis_eks.rules.cis_3_1_2

import data.compliance.cis_eks
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the kubelet kubeconfig file ownership is set to root:root
finding = result {
	data_adapter.filename == "kubeconfig"
	uid = data_adapter.owner_user_id
	gid = data_adapter.owner_group_id
	rule_evaluation := common.file_ownership_match(uid, gid, "root", "root")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"uid": uid, "gid": gid},
	}
}

metadata = {
	"name": "Ensure that the kubelet kubeconfig file ownership is set to root:root",
	"description": "If kubelet is running, ensure that the file ownership of its kubeconfig file is set to root:root.",
	"impact": "None",
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.1.2", "Worker Node Configuration"]),
	"benchmark": cis_eks.benchmark_name,
	"remediation": "chown root:root /var/lib/kubelet/kubeconfig",
}
