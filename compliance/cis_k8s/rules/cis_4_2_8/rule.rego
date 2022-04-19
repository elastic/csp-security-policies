package compliance.cis_k8s.rules.cis_4_2_8

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

# Ensure that the --hostname-override argument is not set.
# Note This setting is not configurable via the Kubelet config file.
rule_evaluation = false {
	common.contains_key(process_args, "--hostname-override")
}

# Ensure that the --hostname-override argument is not set.
finding = result {
	# filter
	data_adapter.is_kubelet

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {
			"process_args": process_args,
			"process_config": data_adapter.process_config,
		},
	}
}
