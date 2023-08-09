package compliance.policy.gcp.sql.ensure_db_flag

import data.compliance.policy.gcp.data_adapter
import future.keywords.if
import future.keywords.in

#
#finding(flag) = result if {
#	# filter
#	data_adapter.is_cloud_sql
#	data_adapter.is_sql_server
#
#	# set result
#	print("is f enabled: ", is_flag_enabled(flag))
#	result := common.generate_result_without_expected(
#		common.calculate_result(is_flag_enabled(flag)),
#		{"DB Instance": data_adapter.resource},
#	)
#}

is_flag_enabled(flag_name) = false if {
	some db_flag in data_adapter.resource.data.settings.databaseFlags
	db_flag.name == flag_name
	db_flag.value == "on"
} else = true

is_flag_non_limited(flag_name) = false if {
	some db_flag in data_adapter.resource.data.settings.databaseFlags
	db_flag.name == flag_name
	db_flag.value != 0
} else = true
