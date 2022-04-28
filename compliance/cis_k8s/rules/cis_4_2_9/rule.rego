package compliance.cis_k8s.rules.cis_4_2_9

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --event-qps argument is set to 0 or a level which
# ensures appropriate event capture 

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

rule_evaluation = false {
	common.contains_key_with_value(process_args, "--event-qps", "0")
}

rule_evaluation = false {
	not common.contains_key(process_args, "--event-qps")
	data_adapter.process_config.config.eventRecordQPS == 0
}

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
