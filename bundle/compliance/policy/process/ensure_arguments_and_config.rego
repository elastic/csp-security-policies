package compliance.policy.process.ensure_arguments_and_config

import data.benchmark_data_adapter
import data.compliance.lib.common as lib_common
import data.compliance.policy.process.data_adapter

process_args := data_adapter.process_args(benchmark_data_adapter.process_args_seperator)

finding(rule_evaluation) = result {
	data_adapter.is_kubelet

	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{
			"process_args": process_args,
			"process_config": data_adapter.process_config,
		},
	)
}

process_key_value(entity, value) {
	lib_common.contains_key_with_value(process_args, entity, value)
}

not_process_key_value(entity, value) {
	not lib_common.contains_key_with_value(process_args, entity, value)
}

not_process_arg_variable(entity, variable) {
	not process_args_entity(entity)
	get_from_config(variable)
}

process_arg_variable(entity, variable) {
	process_args_entity(entity)
	get_from_config(variable)
}

not_process_contains_variable(entity, value, variable) {
	not contains(get_from_process_args(entity), value)
	get_from_config(variable)
}

process_arg_not_key_value(entity, key, value) {
	process_args_entity(entity)
	not_process_key_value(key, value)
}

process_key(entity) {
	lib_common.contains_key(process_args, entity)
}

not_process_key_comparison(entity, variable, value) {
	not process_key(entity)
	get_from_config(variable) == value
}

not_process_arg_comparison(entity, variable, value) {
	not process_args_entity(entity)
	get_from_config(variable) == value
}

process_arg_multi(fEntity, sEntity) {
	process_args_entity(fEntity)
	process_args_entity(sEntity)
}

process_variable(variable) {
	get_from_config(variable)
}

process_args_entity(entity) {
	process_args[entity]
}

process_variable_multi(fVariable, sVariable) {
	process_variable(fVariable)
	process_variable(sVariable)
}

process_filter_variable_multi_comparison(fVariable, sVariable, value) {
	process_variable(fVariable)
	not get_from_config(sVariable) == value
}

get_from_config(path) = r {
	# TODO: Resolve default value
	r := object.get(data_adapter.process_config.config, path, "undefined")
}

get_from_process_args(entity) = r {
	r := process_args[entity]
}
