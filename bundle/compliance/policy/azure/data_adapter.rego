package compliance.policy.azure.data_adapter

resource = input.resource

properties = resource.properties

is_bastion {
	input.type == "azure-bastion"
}

bastions = resource.assets

is_disk {
	input.type == "azure-disk"
}

is_unattached_disk {
	is_disk
	properties.diskState == "Unattached"
}

private_endpoint_connections = properties.privateEndpointConnections

network_acls = properties.networkAcls

activity_log_alerts = resource.activity_log_alerts

is_storage_account {
	input.type == "azure-storage-account"
}

is_activity_log_alerts {
	input.type == "azure-activity-log-alert"
}

is_storage_account {
	input.type == "azure-classic-storage-account"
}

is_postgresql_server_db {
	input.type == "azure-postgresql-server-db"
}

is_mysql_server_db {
	input.type == "azure-mysql-server-db"
}

is_website_asset {
	input.type == "azure-web-site"
}
