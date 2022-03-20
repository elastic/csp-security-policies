package compliance.cis_k8s.rules.cis_4_2_3

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = false

process_args := data_adapter.process_args

contains_ca_file {
	common.contains_key(process_args, "--client-ca-file")
}

rule_evaluation {
	contains_ca_file
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
# Checks that the entry for authentication:x509:clientCAFile: set to a valid path.
rule_evaluation {
	not contains_ca_file
	data_adapter.process_config.config.authentication.x509.clientCAFile
	not data_adapter.process_config.config.authentication.x509.clientCAFile == ""
}

# Ensure that the --client-ca-file argument is set as appropriate (Automated)
finding = result {
	# filter
	data_adapter.is_kubelet

	# evaluate
	process_args := data_adapter.process_args

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
	"name": "Ensure that the --client-ca-file argument is set as appropriate",
	"description": "Enable Kubelet authentication using certificates.",
	"impact": "You require TLS to be configured on apiserver as well as kubelets.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.3", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": "If using a Kubelet config file, edit the file to set authentication: x509: clientCAFile to the location of the client CA file. If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_AUTHZ_ARGS variable. --client-ca-file=<path/to/client-ca-file> Based on your system, restart the kubelet service.",
	"default_value": "By default, --client-ca-file argument is not set.",
}
