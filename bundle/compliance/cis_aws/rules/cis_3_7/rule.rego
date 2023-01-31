package compliance.cis_aws.rules.cis_3_7

import data.compliance.lib.common
import data.compliance.policy.aws_cloudtrail.data_adapter

# Ensure CloudTrail logs are encrypted at rest using KMS CMKs.
finding = result {
	# filter
	data_adapter.is_trail

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(data_adapter.trail.KmsKeyId != null),
		input.resource,
	)
}
