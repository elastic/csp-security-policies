package compliance.cis_gcp.rules.cis_7_3

import data.compliance.lib.common
import data.compliance.policy.gcp.bq.ensure_cmek_is_used as audit

# Ensure That a Default Customer-Managed Encryption Key (CMEK) Is Specified for All BigQuery Data Sets.
finding = result {
	# filter
	common.is_gcp_subtype("gcp-bigquery-dataset")

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_cmek_used),
		{"BigQuery Dataset": input.resource},
	)
}
