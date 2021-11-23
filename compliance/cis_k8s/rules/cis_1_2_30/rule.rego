package compliance.cis_k8s.rules.cis_1_2_30

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Automated)
command_args := data_adapter.command_args

rule_evaluation {
	common.array_contains(command_args, "--tls-cert-file=")
	common.array_contains(command_args, "--tls-private-key-file=")
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
	"name": "Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate",
	"description": "API server communication contains sensitive parameters that should remain encrypted in transit. Configure the API server to serve only HTTPS traffic.",
	"impact": "TLS and client certificate authentication must be configured for your Kubernetes cluster deployment.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.30", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Follow the Kubernetes documentation and set up the TLS connection on the apiserver. Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the TLS certificate and private key file parameters.",
}
