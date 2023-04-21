package compliance.cis_aws.rules.cis_1_20

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter
import future.keywords.if
import future.keywords.in

# Ensure that IAM Access analyzer is enabled for all regions
finding = result if {
	# filter
	data_adapter.is_access_analyzer_for_region

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(analyzer_exists),
		{"Access Analyzers": input.resource},
	)
}

analyzer_exists if {
	some analyzer in data_adapter.analyzers
	analyzer.Status == "ACTIVE"
} else = false
