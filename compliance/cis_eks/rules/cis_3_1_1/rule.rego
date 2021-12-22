package compliance.cis_eks.rules.cis_3_1_1

import data.compliance.cis_eks
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the kubeconfig file permissions are set to 644 or more restrictive
finding = result {
	data_adapter.filename == "kubeconfig"
	filemode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(filemode, 6, 4, 4)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"uid": uid, "gid": gid},
	}
}

metadata = {
	"name": "Ensure that the kubeconfig file permissions are set to 644 or more restrictive",
	"description": "If kubelet is running, and if it is using a file-based kubeconfig file, ensure that the proxy kubeconfig file has permissions of 644 or more restrictive.",
	"impact": "None",
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.1.1", "Worker Node Configuration"]),
	"benchmark": cis_eks.benchmark_name,
	"remediation": "chmod 644 /var/lib/kubelet/kubeconfig",
}
