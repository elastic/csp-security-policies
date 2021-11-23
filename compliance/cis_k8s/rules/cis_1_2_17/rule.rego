package compliance.cis_k8s.rules.cis_1_2_17

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the admission control plugin NodeRestriction is set (Automated)
command_args := data_adapter.command_args

rule_evaluation {
	# Verify that the --enable-admission-plugins argument is set to a value that includes NodeRestriction..
	common.array_contains(command_args, "--enable-admission-plugins=")
	common.arg_values_contains(command_args, "--enable-admission-plugins", "NodeRestriction")
} else = false {
	true
}

finding = result {
	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the admission control plugin NodeRestriction is set",
	"description": "Using the NodeRestriction plug-in ensures that the kubelet is restricted to the Node and Pod objects that it could modify as defined. Such kubelets will only be allowed to modify their own Node API object, and only modify Pod API objects that are bound to their node.",
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.17", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Follow the Kubernetes documentation and configure NodeRestriction plug-in on kubelets. Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the --enable-admission-plugins parameter to a value that includes NodeRestriction.",
}
