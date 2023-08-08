package compliance.policy.gcp.sql.ensure_db_flag

import future.keywords.if
import future.keywords.in

finding(flag, expected_val, fallback) = result if {
	# filter
	data_adapter.is_cloud_sql
	data_adapter.is_sql_server

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(rule_evaluation(flag, expected_val, fallback)),
		{"DB Instance": data_adapter.resource},
	)
}

rule_evaluation(flag, expected_val, fallback) if {
    some db_flag in data_adapter.resource.data.settings.databaseFlags
    db_flag.name == flag
    db_flag.value == expected_val
} else = false

rule_evaluation(flag, expected_val, fallback) if {
    some db_flag in data_adapter.resource.data.settings.databaseFlags
    db_flag.name == flag
} else = fallback
