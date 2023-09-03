package compliance.cis_gcp.rules.cis_1_12

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import future.keywords.if

finding = result if {
	common.is_gcp_subtype("gcp-apikeys-key")

	is_project_apikey := startswith(data_adapter.resource.data.name, "projects/")

	result := common.generate_result_without_expected(
		common.calculate_result(is_project_apikey == false),
		data_adapter.resource.data.name,
	)
}
