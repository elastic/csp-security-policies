package compliance.cis_k8s.rules.cis_1_3_5

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --root-ca-file argument is set as appropriate (Automated)
finding = result {
	# filter
	data_adapter.is_kube_controller_manger

	# evaluate
	process_args := cis_k8s.data_adapter.process_args
	rule_evaluation := common.contains_key(process_args, "--root-ca-file")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"process_args": process_args},
	}
}
