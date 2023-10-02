package compliance.cis_azure.rules.cis_9_4

import data.compliance.lib.common
import data.compliance.policy.azure.data_adapter

finding = result {
	# filter
	data_adapter.is_website_asset

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(is_client_cert_mode_required),
		data_adapter.resource,
	)
}

is_client_cert_mode_required {
	data_adapter.properties.clientCertMode == "Required"
} else = false
