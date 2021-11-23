package compliance.cis_k8s.rules.cis_1_2_26

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --request-timeout argument is set as appropriate (Automated)
finding = result {
	command_args := data_adapter.command_args
	rule_evaluation = common.arg_at_least(command_args, "--request-timeout", 61)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --request-timeout argument is set as appropriate",
	"description": "Setting global request timeout allows extending the API server request timeout limit to a duration appropriate to the user's connection speed. By default, it is set to 60 seconds which might be problematic on slower connections making cluster resources inaccessible once the data volume for requests exceeds what can be transmitted in 60 seconds. But, setting this timeout limit to be too large can exhaust the API server resources making it prone to Denial-of-Service attack. Hence, it is recommended to set this limit as appropriate and change the default limit of 60 seconds only if needed.",
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.26", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml and set the below parameter as appropriate and if needed. For example: --request-timeout=300s",
}
