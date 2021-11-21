package compliance.cis_k8s.rules.cis_1_3_5

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --root-ca-file argument is set as appropriate (Automated)
finding = result {
	command_args := data_adapter.controller_manager_args
	rule_evaluation := common.array_contains(command_args, "--root-ca-file=")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --root-ca-file argument is set as appropriate",
	"description": "Processes running within pods that need to contact the API server must verify the API server's serving certificate. Failing to do so could be a subject to man-in-the-middle attacks. Providing the root certificate for the API server's serving certificate to the controller manager with the --root-ca-file argument allows the controller manager to inject the trusted bundle into pods so that they can verify TLS connections to the API server.",
	"impact": "You need to setup and maintain root certificate authority file.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 1.3.5", "Master Node Configuration"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the Controller Manager pod specification file /etc/kubernetes/manifests/kube- controller-manager.yaml on the master node and set the --root-ca-file parameter to the certificate bundle file` --root-ca-file=<path/to/file>",
}
