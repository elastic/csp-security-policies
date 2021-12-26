package compliance.cis_k8s.rules.cis_5_2_6

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Minimize the admission of root containers (Automated)

# evaluate
default rule_evaluation = false

# Verify that there is at least one PSP which returns MustRunAsNonRoot or MustRunAs with the range of UIDs not including 0.
rule_evaluation {
	# Verify that there is at least one PSP which returns MustRunAsNonRoot.
	pod := input.resource.pods[_]
	common.contains_key_with_value(pod.spec.runAsUser, "rule", "MustRunAsNonRoot")
}

# or 
rule_evaluation {
	# Verify that there is at least one PSP which returns MustRunAs with the range of UIDs not including 0.
	pod := input.resource.pods[_]
	common.contains_key_with_value(pod.spec.runAsUser, "rule", "MustRunAs")
	range := pod.spec.runAsUser.ranges[_]
	range.min > 0
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
	"rule": object.get(pod.spec, "pod.spec.runAsUser", "unknown"),
}

metadata = {
	"name": "Minimize the admission of root containers",
	"description": "Do not generally permit containers to be run as the root user.",
	"rationale": `Containers may run as any Linux user. Containers which run as the root user, whilst constrained by Container Runtime security features still have a escalated likelihood of container breakout.
Ideally, all containers should run as a defined non-UID 0 user.
There should be at least one PodSecurityPolicy (PSP) defined which does not permit root users in a container.
If you need to run root containers, this should be defined in a separate PSP and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that PSP.`,
	"impact": "Pods with containers which run as the root user will not be permitted.",
	"remediation": "Create a PSP as described in the Kubernetes documentation, ensuring that the .spec.runAsUser.rule is set to either MustRunAsNonRoot or MustRunAs with the range of UIDs not including 0.",
	"default_value": "By default, PodSecurityPolicies are not defined.",
	"benchmark": cis_k8s.benchmark_name,
	"tags": array.concat(cis_k8s.default_tags, ["CIS 5.2.6", "Pod Security Policies"]),
}
