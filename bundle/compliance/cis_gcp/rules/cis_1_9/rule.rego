package compliance.cis_gcp.rules.cis_1_9

import data.compliance.lib.common
import data.compliance.policy.gcp.kms.data_adapter
import data.compliance.policy.gcp.kms.ensure_no_public_key as audit

# Ensure That Cloud KMS Cryptokeys Are Not Anonymously or Publicly Accessible.
finding = result {
	# filter
	data_adapter.is_kms_key

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.key_is_public == false),
		{"Kms key": input},
	)
}
