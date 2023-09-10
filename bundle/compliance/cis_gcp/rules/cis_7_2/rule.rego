package compliance.cis_gcp.rules.cis_7_2

import data.compliance.lib.common
import data.compliance.policy.gcp.bq.ensure_cmek_is_used as audit

# Ensure That All BigQuery Tables Are Encrypted With Customer-Managed Encryption Keys (CMEK).
finding = result {
	# filter
	common.is_gcp_subtype("gcp-bigquery-table")

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_cmek_used),
		{"BigQuery Table": input.resource},
	)
}
