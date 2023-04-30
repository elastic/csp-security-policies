package compliance.cis_aws.rules.cis_1_20

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter
import future.keywords.every
import future.keywords.if
import future.keywords.in

# Ensure that IAM Access analyzer is enabled for all regions
finding = result if {
	# filter
	data_adapter.is_access_analyzers

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(count(regions_without_analyzers) == 0),
		{"Regions without access analyzers": regions_without_analyzers},
	)
}

regions_without_analyzers = {region |
	analyzers := data_adapter.analyzers[region]
	not analyzer_exists(analyzers)
}

analyzer_exists(analyzers) if {
	some analyzer in analyzers
	analyzer.Status == "ACTIVE"
} else = false
