package compliance.cis_gcp.rules.cis_1_14

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

default is_valid = false

is_valid if {
	api_targets = data_adapter.resource.data.restrictions.apiTargets[_]
	api_targets != "cloudapis.googleapis.com"
}

finding = result if {
	data_adapter.is_iam_service_account_key

	result := common.generate_result_without_expected(
		common.calculate_result(is_valid),
		data_adapter.resource.data,
	)
}
