package compliance.cis_k8s.rules.cis_4_2_4

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = false

process_args := cis_k8s.data_adapter.process_args

rule_evaluation {
	common.contains_key_with_value(process_args, "--read-only-port", "0")
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation {
	not process_args["--read-only-port"]
	data_adapter.process_config.config.readOnlyPort == 0
}

# Verify that the --read-only-port argument is set to 0
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
	"name": "Verify that the --read-only-port argument is set to 0",
	"description": "Disable the read-only port.",
	"rationale": `The Kubelet process provides a read-only API in addition to the main Kubelet API.
Unauthenticated access is provided to this read-only API which could possibly retrieve  potentially sensitive information about the cluster.`,
	"impact": "Removal of the read-only port will require that any service which made use of it will need to be re-configured to use the main Kubelet API.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.4", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `If using a Kubelet config file, edit the file to set readOnlyPort to 0.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
--read-only-port=0
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default, --read-only-port is set to 10255/TCP. However, if a config file is specified by --config the default value for readOnlyPort is 0.",
}
