package compliance.cis_k8s.rules.cis_1_2_16

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the admission control plugin PodSecurityPolicy is set (Automated)
command_args := data_adapter.command_args

rule_evaluation {
	# Verify that the --enable-admission-plugins argument is set to a value that includes PodSecurityPolicy.
	common.array_contains(command_args, "--enable-admission-plugins=")
	common.arg_values_contains(command_args, "--enable-admission-plugins", "PodSecurityPolicy")
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
	"name": "Ensure that the admission control plugin PodSecurityPolicy is set",
	"description": "A Pod Security Policy is a cluster-level resource that controls the actions that a pod can perform and what it has the ability to access. The PodSecurityPolicy objects define a set of conditions that a pod must run with in order to be accepted into the system. Pod Security Policies are comprised of settings and strategies that control the security features a pod has access to and hence this must be used to control pod access permissions.",
	"impact": "The policy objects must be created and granted before pod creation would be allowed.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.16", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the API server pod specification file /etc/kubernetes/manifests/kube- apiserver.yaml on the master node and set the --disable-admission-plugins parameter to ensure it does not include NamespaceLifecycle.",
}