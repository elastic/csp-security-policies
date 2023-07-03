package compliance.cis_gcp.rules.cis_5_1

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import data.compliance.policy.gcp.iam.ensure_no_public_access as audit

# Ensure That Cloud Storage Bucket Is Not Anonymously or Publicly Accessible.
finding = result {
	# filter
	data_adapter.is_gcs_bucket

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.resource_is_public == false),
		{"Gcs Bucket": input.resource},
	)
}
