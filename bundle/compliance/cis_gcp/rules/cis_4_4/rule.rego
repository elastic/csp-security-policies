package compliance.cis_gcp.rules.cis_4_4

import data.compliance.lib.common
import data.compliance.policy.gcp.compute.assess_instance_metadata as audit
import data.compliance.policy.gcp.data_adapter

# Ensure Oslogin Is Enabled for a Project
finding = result {
	# filter
	data_adapter.is_compute_instance

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_instance_metadata_valid("enable-oslogin", "true")),
		{"Compute instance": input.resource},
	)
}
