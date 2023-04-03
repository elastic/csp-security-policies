package compliance.policy.aws_config.ensure_config_enabled

import data.compliance.lib.common as common
import data.compliance.policy.aws_config.data_adapter

default rule_evaluation = false

rule_evaluation {
	data_adapter.recorders[_].recordingGroup.allSupported == true
	data_adapter.recorders[_].recordingGroup.includeGlobalResourceTypes == true
}

finding = result {
	data_adapter.is_config

	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		data_adapter.recorders,
	)
}
