package compliance.cis_eks.rules.cis_3_1_3

import data.compliance.cis_eks
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the kubelet configuration file has permissions set to 644 or more restrictive
finding = result {
	# filter
	data_adapter.filename == "kubelet-config.json"

	# evaluate
	filemode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(filemode, 6, 4, 4)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"filemode": filemode},
	}
}

metadata = {
	"name": "Ensure that the kubelet configuration file has permissions set to 644 or more restrictive",
	"description": "Ensure that if the kubelet refers to a configuration file with the --config argument, that file has permissions of 644 or more restrictive.",
	"impact": "None",
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.1.3", "Worker Node Configuration"]),
	"benchmark": cis_eks.benchmark_name,
	"remediation": "chmod 644 /etc/kubernetes/kubelet/kubelet-config.json",
}
