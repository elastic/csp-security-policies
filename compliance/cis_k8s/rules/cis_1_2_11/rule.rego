package compliance.cis_k8s.rules.cis_1_2_11

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the admission control plugin AlwaysAdmit is not set (Automated)
finding = result {
	command_args := data_adapter.command_args
	rule_evaluation := contains(command_args, "--enable-admission-plugins=AlwaysAdmit") == false

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the admission control plugin AlwaysAdmit is not set",
	"description": "Setting admission control plugin AlwaysAdmit allows all requests and do not filter any requests.",
	"impact": "Only requests explicitly allowed by the admissions control plugins would be served.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.11", "API Server"]),
	"benchmark": "CIS Kubernetes",
	"remediation": "Edit the API server pod specification file /etc/kubernetes/manifests/kube- apiserver.yaml on the master node and either remove the --enable-admission-plugins parameter, or set it to a value that does not include AlwaysAdmit.",
}
