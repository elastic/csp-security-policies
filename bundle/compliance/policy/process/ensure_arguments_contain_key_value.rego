package compliance.policy.process.ensure_arguments_contain_key_value

import data.compliance.lib.assert
import data.compliance.lib.common as lib_common
import data.compliance.policy.process.common as process_common
import data.compliance.policy.process.data_adapter

finding(rule_evaluation) = result {
	# set result
	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{"process_args": data_adapter.process_args},
	)
}

not_contains(entity, value) := assert.is_false(process_common.contains_key_with_value(data_adapter.process_args, entity, value))

contains(entity, value) := process_common.contains_key_with_value(data_adapter.process_args, entity, value)

apiserver_filter := data_adapter.is_kube_apiserver

controller_manager_filter := data_adapter.is_kube_controller_manager

scheduler_filter := data_adapter.is_kube_scheduler

etcd_filter := data_adapter.is_etcd
