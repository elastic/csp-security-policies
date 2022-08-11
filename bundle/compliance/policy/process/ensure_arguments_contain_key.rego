package compliance.policy.process.ensure_arguments_contain_key

import data.compliance.lib.assert
import data.compliance.lib.common as lib_common
import data.compliance.policy.process.common as process_common
import data.compliance.policy.process.data_adapter

finding(rule_evaluation) = result {
	data_adapter.is_kube_apiserver

	# set result
	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{"process_args": data_adapter.process_args},
	)
}

not_contains(entity) := assert.is_false(process_common.contains_key(data_adapter.process_args, entity))

contains(entity) := process_common.contains_key(data_adapter.process_args, entity)
