package compliance.cis_eks.rules.cis_3_2_7

import data.compliance.cis_eks
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --make-iptables-util-chains argument is set to true (Automated)

# todo: If the --make-iptables-util-chains argument does not exist, and there is a Kubelet config file specified by --config, verify that the file does not set makeIPTablesUtilChains to false.
finding = result {
	# filter
	data_adapter.is_kubelet

	# evaluate
	process_args := data_adapter.process_args
	rule_evaluation = assert.is_false(common.contains_key_with_value(process_args, "--make-iptables-util-chains", "false"))

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}

metadata = {
	"name": "Ensure that the --make-iptables-util-chains argument is set to true",
	"description": "Allow Kubelet to manage iptables.",
	"impact": `Kubelets can automatically manage the required changes to iptables based on how you choose your networking options for the pods.
It is recommended to let kubelets manage the changes to iptables.
This ensures that the iptables configuration remains in sync with pods networking configuration.
Manually configuring iptables with dynamic pod network configuration changes might hamper the communication between pods/containers and to the outside world.
You might have iptables rules too restrictive or too open.`,
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.2.7", "Kubelet"]),
	"benchmark": cis_eks.benchmark_metadata,
	"remediation": `If modifying the Kubelet config file, edit the kubelet-config.json file /etc/kubernetes/kubelet/kubelet-config.json and set the below parameter to false
"makeIPTablesUtilChains": true
If using executable arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubelet-args.conf on each worker node and add the below parameter at the end of the KUBELET_ARGS variable string.
--make-iptables-util-chains:true
If using the api configz endpoint consider searching for the status of "makeIPTablesUtilChains": true by extracting the live configuration from the nodes running kubelet.`,
	"default_value": "See the Amazon EKS documentation for the default value.",
	"rationale": `Kubelets can automatically manage the required changes to iptables based on how you choose your networking options for the pods.
It is recommended to let kubelets manage the changes to iptables.
This ensures that the iptables configuration remains in sync with pods networking configuration.
Manually configuring iptables with dynamic pod network configuration changes might hamper the communication between pods/containers and to the outside world.
You might have iptables rules too restrictive or too open.`,
}
