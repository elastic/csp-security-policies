package compliance.cis_eks.rules.cis_4_2_4

import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Minimize the admission of containers wishing to share the host network namespace (Automated)
finding = result {
	# filter
	data_adapter.is_kube_api

	# evaluate
	rule_evaluation := assert.is_false(common.contains_key_with_value(data_adapter.pod.spec, "hostNetwork", true))

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": json.filter(data_adapter.pod, ["uid", "spec/hostNetwork"]),
	}
}

metadata = {
	"name": "Minimize the admission of containers wishing to share the host network namespace",
	"description": "Do not generally permit containers to be run with the hostNetwork flag set to true.",
	"rationale": `A container running in the host's network namespace could access the local loopback device, and could access network traffic to and from other pods.
There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host network namespace.
If you have need to run containers which require hostNetwork, this should be defined in a separate PSP and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that PSP.`,
	"impact": "Pods defined with spec.hostNetwork: true will not be permitted unless they are run under a specific PSP.",
	"remediation": "Create a PSP as described in the Kubernetes documentation, ensuring that the .spec.hostNetwork field is omitted or set to false.",
	"default_value": "By default, PodSecurityPolicies are not defined.",
	"benchmark": cis_eks.benchmark_metadata,
	"tags": array.concat(cis_eks.default_tags, ["CIS 4.2.4", "Pod Security Policies"]),
}
