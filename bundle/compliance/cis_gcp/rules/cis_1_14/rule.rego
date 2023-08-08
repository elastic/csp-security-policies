package compliance.cis_gcp.rules.cis_1_14

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

default has_valid_apikey_restrictions = false

finding = result if {
	data_adapter.is_api_key

	result := common.generate_result_without_expected(
		common.calculate_result(has_valid_apikey_restrictions == true),
		data_adapter.resource.data,
	)
}

has_valid_apikey_restrictions if {
	common.contains_key(data_adapter.resource.data, "restrictions")
	api_targets := data_adapter.resource.data.restrictions.apiTargets[i]
	api_targets.service != "cloudapis.googleapis.com"
}
