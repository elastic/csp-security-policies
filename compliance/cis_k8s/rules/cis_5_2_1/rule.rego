package compliance.cis_k8s.rules.cis_5_2_1

import data.compliance.cis_k8s
import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# evaluate
process_args := data_adapter.process_args

default rule_evaluation = false

rule_evaluation {
	# Verify that there is at least one PSP which does not return true.
	pod := input.resource.pods[i]
	securityContext := pod.spec.securityContext
	assert.is_false(common.contains_key_with_value(securityContext, "privileged", true))
}

# Minimize the admission of privileged containers (Automated)
finding = result {
	# filter
	data_adapter.is_kube_api

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": "None",
	}
}

metadata = {
	"name": "Minimize the admission of privileged containers",
	"description": "Do not generally permit containers to be run with the securityContext.privileged flag set to true.",
	"impact": "Pods defined with spec.containers[].securityContext.privileged: true will not be permitted.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 5.2.1", "Pod Security Policies"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Create a PSP as described in the Kubernetes documentation, ensuring that the .spec.privileged field is omitted or set to false.",
}
