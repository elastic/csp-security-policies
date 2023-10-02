package compliance.policy.azure.data_adapter

resource = input.resource

properties = resource.properties

is_storage_account {
	input.type == "azure-storage-account"
}

is_postgresql_server_db {
	input.type == "azure-postgresql-server-db"
}

is_mysql_server_db {
	input.type == "azure-mysql-server-db"
}
