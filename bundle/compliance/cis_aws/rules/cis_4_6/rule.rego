package compliance.cis_aws.rules.cis_4_6

import data.compliance.lib.common
import data.compliance.policy.aws_cloudtrail.data_adapter
import data.compliance.policy.aws_cloudtrail.trail

default rule_evaluation = false

finding = result {
	# filter 
	data_adapter.is_multi_trails_type

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation),
		input.resource,
	)
}

required_patterns = ["{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"]

rule_evaluation = trail.at_least_one_trail_satisfied(required_patterns)
