package compliance.cis_k8s.rules.cis_1_3_7

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --bind-address argument is set to 127.0.0.1 (Automated)
finding = result {
	command_args := data_adapter.controller_manager_args
	rule_evaluation := common.array_contains(command_args, "--bind-address=127.0.0.1")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --bind-address argument is set to 127.0.0.1",
	"description": "Do not bind the Controller Manager service to non-loopback insecure addresses.",
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.3.7", "Controller Manager"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the Controller Manager pod specification file /etc/kubernetes/manifests/kube- controller-manager.yaml on the master node and ensure the correct value for the -- bind-address parameter",
}
