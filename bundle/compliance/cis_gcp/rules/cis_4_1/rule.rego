package compliance.cis_gcp.rules.cis_4_1

import data.compliance.lib.assert
import data.compliance.lib.common
import data.compliance.policy.gcp.compute.ensure_default_sa as audit

# Ensure That Instances Are Not Configured To Use the Default Service Account.
finding = result {
	# filter
	common.is_gcp_subtype("gcp-compute-instance")

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(assert.is_false(audit.sa_is_default)),
		{"Compute instance": input.resource},
	)
}
