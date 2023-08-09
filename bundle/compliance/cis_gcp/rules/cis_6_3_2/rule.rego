package compliance.cis_gcp.rules.cis_6_3_2

import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import data.compliance.policy.gcp.sql.ensure_db_flag as audit

finding = result {
	# filter
	data_adapter.is_cloud_sql
	data_adapter.is_sql_server

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(audit.is_flag_enabled("cross db ownership chaining")),
		{"DB Instance": data_adapter.resource},
	)
}
