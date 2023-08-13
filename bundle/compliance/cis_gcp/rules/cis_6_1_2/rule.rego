package compliance.cis_gcp.rules.cis_6_1_2

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter

finding = result {
	data_adapter.is_cloud_sql

	result := common.generate_result_without_expected(
		common.calculate_result(is_local_infile_flag_disabled),
		data_adapter.resource,
	)
}

is_local_infile_flag_disabled {
	flags := data_adapter.resource.settings.databaseFlags[_]
	flags.name == "skip_show_database"
	flags.value == "off"
} else = false
