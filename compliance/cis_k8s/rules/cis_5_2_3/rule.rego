package compliance.cis_k8s.rules.cis_5_2_3

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Minimize the admission of containers wishing to share the host IPC namespace (Automated)

# evaluate
default rule_evaluation = false

rule_evaluation {
	# Verify that there is at least one PSP which does not return true.
	pod := input.resource.pods[_]
	assert.is_false(common.contains_key_with_value(pod.spec, "hostIPC", true))
}

finding = result {
	# filter
	data_adapter.is_kube_api

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {pod_evidance(pod) | pod := input.resource.pods[_]},
	}
}

pod_evidance(pod) = {
	"uid": object.get(pod.metadata, "uid", "unknown"),
	"hostIPC": object.get(pod.spec, "hostIPC", "unknown"),
}

metadata = {
	"name": "Minimize the admission of containers wishing to share the host process ID namespace",
	"description": "Do not generally permit containers to be run with the hostIPC flag set to true.",
	"rationale": `A container running in the host's IPC namespace can use IPC to interact with processes outside the container.
There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host IPC namespace.
If you have a requirement to containers which require hostIPC, this should be defined in a separate PSP and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that PSP.`,
	"impact": "Pods defined with spec.hostIPC: true will not be permitted unless they are run under a specific PSP.",
	"remediation": "Create a PSP as described in the Kubernetes documentation, ensuring that the .spec.hostIPC field is omitted or set to false.",
	"default_value": "By default, PodSecurityPolicies are not defined.",
	"benchmark": cis_k8s.benchmark_name,
	"tags": array.concat(cis_k8s.default_tags, ["CIS 5.2.3", "Pod Security Policies"]),
}
