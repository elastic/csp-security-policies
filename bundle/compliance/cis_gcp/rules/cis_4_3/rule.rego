package compliance.cis_gcp.rules.cis_4_3

import data.compliance.lib.common
import data.compliance.policy.gcp.compute.assess_instance_metadata as audit
import data.compliance.policy.gcp.data_adapter

# Ensure “Block Project-Wide SSH Keys” Is Enabled for VM Instances
finding = result {
	# filter
	data_adapter.is_compute_instance

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_instance_metadata_valid("block-project-ssh-keys", "true")),
		{"Compute instance": input.resource},
	)
}
