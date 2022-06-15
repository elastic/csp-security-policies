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
		"evidence": json.filter(data_adapter.pod, [
			"metadata/user",
			"spec/hostNetwork",
		]),
	}
}
