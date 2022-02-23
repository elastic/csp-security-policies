package compliance.cis_eks.rules.cis_3_2_2

import data.compliance.cis_eks
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --authorization-mode argument is not set to AlwaysAllow (Automated)

# If the --authorization-mode argument is present check that it is not set to AlwaysAllow.

# evaluate
process_args := data_adapter.process_args

default rule_evaluation = false

rule_evaluation {
	process_args["--authorization-mode"]
	assert.is_false(common.arg_values_contains(process_args, "--authorization-mode", "AlwaysAllow"))
}

# todo: If it is not present check that there is a Kubelet config file specified by --config, and that file sets authorization: mode to something other than AlwaysAllow.

finding = result {
	# filter
	data_adapter.is_kubelet

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}

metadata = {
	"name": "Ensure that the --authorization-mode argument is not set to AlwaysAllow",
	"description": "Do not allow all requests. Enable explicit authorization.",
	"impact": "Unauthorized requests will be denied.",
	"tags": array.concat(cis_eks.default_tags, ["CIS 3.2.2", "Kubelet"]),
	"benchmark": cis_eks.benchmark_metadata,
	"remediation": `If modifying the Kubelet config file, edit the kubelet-config.json file /etc/kubernetes/kubelet/kubelet-config.json and set the below parameter to false.
"authentication"... "webhook":{"enabled":true...
If using executable arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubelet-args.conf on each worker node and add the below parameter at the end of the KUBELET_ARGS variable string.
--authorization-mode=Webhook.
If using the api configz endpoint consider searching for the status of "authentication.*webhook":{"enabled":true" by extracting the live configuration from the nodes running kubelet.`,
	"rationale": `Kubelets, by default, allow all authenticated requests (even anonymous ones) without needing explicit authorization checks from the apiserver.
You should restrict this behavior and only allow explicitly authorized requests.`,
	"default_value": "See the EKS documentation for the default value.",
}
