package compliance.policy.aws_rds.ensure_encryption_enabled

import data.compliance.lib.common as lib_common
import data.compliance.policy.aws_rds.data_adapter

default rule_evaluation = false

rule_evaluation {
	data_adapter.storage_encrypted == true
}

finding = result {
	data_adapter.is_rds

	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{"StorageEncrypted": data_adapter.storage_encrypted},
	)
}
