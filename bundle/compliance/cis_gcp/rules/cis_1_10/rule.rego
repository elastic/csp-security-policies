package compliance.cis_gcp.rules.cis_1_10

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import data.compliance.policy.gcp.kms.ensure_key_rotation as audit

# Ensure KMS Encryption Keys Are Rotated Within a Period of 90 Days.
finding = result {
	# filter
	data_adapter.is_kms_key

	# In order for an encryption key to be available,
	# it needs to have a primary key version which is enabled
	not data_adapter.resource.data.primary == null
	data_adapter.resource.data.primary.state == "ENABLED"

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.key_is_rotated),
		{"KMS:": data_adapter.resource},
	)
}
