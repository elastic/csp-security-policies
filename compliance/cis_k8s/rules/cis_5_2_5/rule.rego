package compliance.cis_k8s.rules.cis_5_2_5

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Minimize the admission of containers with allowPrivilegeEscalation (Automated)

# evaluate
default rule_evaluation = false

rule_evaluation {
	# Verify that there is at least one PSP which does not return true.
	pod := input.resource.pods[_]
	assert.is_false(common.contains_key_with_value(pod.spec, "allowPrivilegeEscalation", true))
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
	"allowPrivilegeEscalation": object.get(pod.spec, "allowPrivilegeEscalation", "unknown"),
}

metadata = {
	"name": "Minimize the admission of containers with allowPrivilegeEscalation",
	"description": "Do not generally permit containers to be run with the allowPrivilegeEscalation flag set to true",
	"rationale": `A container running with the allowPrivilegeEscalation flag set to true may have processes that can gain more privileges than their parent.
There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to allow privilege escalation. The option exists (and is defaulted to true) to permit setuid binaries to run.
If you have need to run containers which use setuid binaries or require privilege escalation,
this should be defined in a separate PSP and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that PSP.`,
	"impact": "Pods defined with spec.allowPrivilegeEscalation: true will not be permitted unless they are run under a specific PSP.",
	"remediation": "Create a PSP as described in the Kubernetes documentation, ensuring that the .spec.allowPrivilegeEscalation field is omitted or set to false.",
	"default_value": "By default, PodSecurityPolicies are not defined.",
	"benchmark": cis_k8s.benchmark_name,
	"tags": array.concat(cis_k8s.default_tags, ["CIS 5.2.5", "Pod Security Policies"]),
}
