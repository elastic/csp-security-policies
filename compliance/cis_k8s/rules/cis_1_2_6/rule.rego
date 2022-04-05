package compliance.cis_k8s.rules.cis_1_2_6

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)
finding = result {
	# filter
	data_adapter.is_kube_apiserver

	# evaluate
	process_args := cis_k8s.data_adapter.process_args
	rule_evaluation = assert.is_false(common.arg_values_contains(process_args, "--authorization-mode", "AlwaysAllow"))

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}

metadata = {
	"name": "Ensure that the --authorization-mode argument is not set to AlwaysAllow",
	"description": "The API Server, can be configured to allow all requests. This mode should not be used on any production cluster.",
	"impact": "Only authorized requests will be served.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.6", "API Server"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": "Edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the --authorization-mode parameter to values other than AlwaysAllow",
}
