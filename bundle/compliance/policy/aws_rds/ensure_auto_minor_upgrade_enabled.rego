package compliance.policy.aws_rds.ensure_auto_minor_upgrade_enabled

import data.compliance.lib.common as lib_common
import data.compliance.policy.aws_rds.data_adapter

default rule_evaluation = false

rule_evaluation {
	data_adapter.auto_minor_version_upgrade == true
}

finding = result {
	data_adapter.is_rds

	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{"AutoMinorVersionUpgrade": data_adapter.auto_minor_version_upgrade},
	)
}
