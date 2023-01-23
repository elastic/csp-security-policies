package compliance.cis_aws.rules.cis_3_2

import data.compliance.lib.common
import data.compliance.policy.aws_cloudtrail.data_adapter

# Ensure CloudTrail log file validation is enabled.
finding = result {
	# filter
	data_adapter.is_trail

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(data_adapter.trail.log_file_validation_enabled),
		data_adapter.trail,
	)
}
