package compliance.cis_k8s.rules.cis_1_2_32

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --etcd-cafile argument is set as appropriate (Automated)
finding = result {
	command_args := data_adapter.command_args
	rule_evaluation = common.array_contains(command_args, "--etcd-cafile=")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --etcd-cafile argument is set as appropriate",
	"description": "etcd is a highly-available key value store used by Kubernetes deployments for persistent storage of all of its REST API objects. These objects are sensitive in nature and should be protected by client authentication. This requires the API server to identify itself to the etcd server using a SSL Certificate Authority file.",
	"impact": "TLS and client certificate authentication must be configured for etcd.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.32", "API Server"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Follow the Kubernetes documentation and set up the TLS connection on the apiserver. Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the client certificate authority file.",
}
