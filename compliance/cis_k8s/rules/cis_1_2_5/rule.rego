package compliance.cis_k8s.rules.cis_1_2_5

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate (Automated)
command_args := data_adapter.command_args

rule_evaluation {
	common.array_contains(command_args, "--kubelet-client-certificate=")
	common.array_contains(command_args, "--kubelet-client-key=")
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
	"name": "Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate",
	"description": "The apiserver, by default, does not authenticate itself to the kubelet's HTTPS endpoints. The requests from the apiserver are treated anonymously. You should set up certificate- based kubelet authentication to ensure that the apiserver authenticates itself to kubelets when submitting requests.",
	"impact": "You require TLS to be configured on apiserver as well as kubelets.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.5", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Follow the Kubernetes documentation and set up the TLS connection between the apiserver and kubelets. Then, edit API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the kubelet client certificate and key parameters",
}
