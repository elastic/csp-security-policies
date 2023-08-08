package compliance.cis_gcp.rules.cis_1_14

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

finding = result if {
	data_adapter.is_api_key

	api_targets := data_adapter.resource.data.restrictions.apiTargets[i]

	result := common.generate_result_without_expected(
		common.calculate_result(api_targets.service != "cloudapis.googleapis.com"),
		data_adapter.resource.data.restrictions,
	)
}
