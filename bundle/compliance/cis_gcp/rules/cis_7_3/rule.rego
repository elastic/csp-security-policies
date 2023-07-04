package compliance.cis_gcp.rules.cis_7_3

import data.compliance.lib.common
import data.compliance.policy.gcp.bq.ensure_cmek_is_used as audit
import data.compliance.policy.gcp.data_adapter

# Ensure That All BigQuery Tables Are Encrypted With Customer-Managed Encryption Keys (CMEK).
finding = result {
	# filter
	data_adapter.is_bq_dataset

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_cmek_used),
		{"Big Query Dataset": input.resource},
	)
}
