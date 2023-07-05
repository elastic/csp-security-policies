package compliance.cis_gcp.rules.cis_7_1

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import data.compliance.policy.gcp.iam.ensure_no_public_access as audit

# Ensure That BigQuery Datasets Are Not Anonymously or Publicly Accessible.
finding = result {
	# filter
	data_adapter.is_bq_dataset

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.resource_is_public == false),
		{"Big Query Dataset": input.resource},
	)
}
