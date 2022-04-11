package compliance.cis_k8s.rules.cis_4_2_8

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

# Ensure that the --hostname-override argument is not set.
# Note This setting is not configurable via the Kubelet config file.
rule_evaluation = false {
	common.contains_key(process_args, "--hostname-override")
}

# Ensure that the --hostname-override argument is not set.
finding = result {
	# filter
	data_adapter.is_kubelet

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {
			"process_args": process_args,
			"process_config": data_adapter.process_config,
		},
	}
}

metadata = {
	"name": "Ensure that the --hostname-override argument is not set",
	"description": "Do not override node hostnames.",
	"rationale": `Overriding hostnames could potentially break TLS setup between the kubelet and the apiserver.
Additionally, with overridden hostnames, it becomes increasingly difficult to associate logs with a particular node and process them for security analytics.
Hence, you should setup your kubelet nodes with resolvable FQDNs and avoid overriding the hostnames with IPs.`,
	"impact": "Some cloud providers may require this flag to ensure that hostname matches names issued by the cloud provider. In these environments, this recommendation should not apply.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.8", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `Edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and remove the --hostname-override argument from the KUBELET_SYSTEM_PODS_ARGS variable.
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default, --hostname-override argument is not set.",
}
