package compliance.cis_k8s.rules.cis_4_2_5

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

# Ensure that the --streaming-connection-idle-timeout argument is not set to 0
rule_evaluation = false {
	common.contains_key_with_value(process_args, "--streaming-connection-idle-timeout", "0")
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation = false {
	not process_args["--streaming-connection-idle-timeout"]
	data_adapter.process_config.config.streamingConnectionIdleTimeout == 0
}

# Ensure that the --streaming-connection-idle-timeout argument is not set to 0
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
	"name": "Ensure that the --streaming-connection-idle-timeout argument is not set to 0",
	"description": "Do not disable timeouts on streaming connections.",
	"rationale": `Setting idle timeouts ensures that you are protected against Denial-of-Service attacks, inactive connections and running out of ephemeral ports.
Note: By default, --streaming-connection-idle-timeout is set to 4 hours which might be too high for your environment.
Setting this as appropriate would additionally ensure that such streaming connections are timed out after serving legitimate use cases.`,
	"impact": "Long-lived connections could be interrupted.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.5", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `If using a Kubelet config file, edit the file to set streamingConnectionIdleTimeout to a value other than 0.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
--streaming-connection-idle-timeout=5m
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default, --streaming-connection-idle-timeout is set to 4 hours.",
}
