package compliance.cis_gcp.rules.cis_1_10

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import data.compliance.policy.gcp.kms.ensure_key_rotation as audit

# Ensure KMS Encryption Keys Are Rotated Within a Period of 90 Days.
finding = result {
	# filter
	data_adapter.is_kms_key

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.key_is_rotated == true),
		{"KMS:": "zoo"},
	)
}
