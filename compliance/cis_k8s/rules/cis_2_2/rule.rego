package compliance.cis_k8s.rules.cis_2_2

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --client-cert-auth argument is set to true (Automated)
finding = result {
	command_args := data_adapter.etcd_args
	rule_evaluation := common.array_contains(command_args, "--client-cert-auth=true")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --client-cert-auth argument is set to true",
	"description": "Enable client authentication on etcd service.",
	"impact": "All clients attempting to access the etcd server will require a valid client certificate.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 2.2", "etcd"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the etcd pod specification file /etc/kubernetes/manifests/etcd.yaml on the master node and set to --client-cert-auth=true",
}