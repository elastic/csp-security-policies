package cis_azure.test_data

generate_storage_account_encryption(enabled) = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {"encryption": {"requireInfrastructureEncryption": enabled}}},
}

not_eval_storage_account_encryption = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {"encryption": {}}},
}

generate_postgresql_server_with_ssl_enforcement(enabled) = {
	"type": "azure-postgresql-server-db",
	"subType": "",
	"resource": {"properties": {"sslEnforcement": enabled}},
}

generate_mysql_server_with_ssl_enforcement(enabled) = {
	"type": "azure-mysql-server-db",
	"subType": "",
	"resource": {"properties": {"sslEnforcement": enabled}},
}
