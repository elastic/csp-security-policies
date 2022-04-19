package compliance.cis_k8s.rules.cis_4_2_4

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = false

process_args := cis_k8s.data_adapter.process_args

rule_evaluation {
	common.contains_key_with_value(process_args, "--read-only-port", "0")
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation {
	not process_args["--read-only-port"]
	data_adapter.process_config.config.readOnlyPort == 0
}

# Verify that the --read-only-port argument is set to 0
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
