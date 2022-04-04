package compliance.cis_k8s.rules.cis_2_5

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --peer-client-cert-auth argument is set to true (Automated)
finding = result {
	# filter
	data_adapter.is_etcd

	# evaluate
	process_args := cis_k8s.data_adapter.process_args
	rule_evaluation := common.contains_key_with_value(process_args, "--peer-client-cert-auth", "true")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}

metadata = {
	"name": "Ensure that the --peer-client-cert-auth argument is set to true",
	"description": "etcd should be configured for peer authentication.",
	"impact": "All peers attempting to communicate with the etcd server will require a valid client certificate for authentication.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 2.5", "etcd"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": "Edit the etcd pod specification file /etc/kubernetes/manifests/etcd.yaml on the master node and set to --peer-client-cert-auth=true",
}
