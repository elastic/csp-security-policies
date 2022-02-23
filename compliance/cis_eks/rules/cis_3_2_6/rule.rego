package compliance.cis_eks.rules.cis_3_2_6

import data.compliance.cis_eks
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --protect-kernel-defaults argument is set to true (Automated)
# todo: If the --protect-kernel-defaults argument is not present, check that there is a Kubelet config file specified by --config, and that the file sets protectKernelDefaults to true.
finding = result {
	# filter
	data_adapter.is_kubelet

	# evaluate
	process_args := data_adapter.process_args
	rule_evaluation = common.contains_key_with_value(process_args, "--protect-kernel-defaults", "true")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}

metadata = {
	"name": "Ensure that the --protect-kernel-defaults argument is set to true",
	"description": "Protect tuned kernel parameters from overriding kubelet default kernel parameter values.",
	"impact": "You would have to re-tune kernel parameters to match kubelet parameters.",
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.2.6", "Kubelet"]),
	"benchmark": cis_eks.benchmark_metadata,
	"remediation": `If modifying the Kubelet config file, edit the kubelet-config.json file /etc/kubernetes/kubelet/kubelet-config.json and set the below parameter to true
"protectKernelDefaults":
If using a Kubelet config file, edit the file to set protectKernelDefaults to true.
If using executable arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubelet-args.conf on each worker node and add the below parameter at the end of the KUBELET_ARGS variable string.
----protect-kernel-defaults=true
If using the api configz endpoint consider searching for the status of "protectKernelDefaults": by extracting the live configuration from the nodes running kubelet.`,
	"rationale": `Kernel parameters are usually tuned and hardened by the system administrators before putting the systems into production.
These parameters protect the kernel and the system. Your kubelet kernel defaults that rely on such parameters should be appropriately set to match the desired secured system state.
Ignoring this could potentially lead to running pods with undesired kernel behavior.`,
	"default_value": "See the EKS documentation for the default value.",
}
