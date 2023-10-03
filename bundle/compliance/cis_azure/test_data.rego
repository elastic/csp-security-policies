package cis_azure.test_data

not_eval_resource = {
	"type": "azure-resource-type",
	"subType": "azure-resource-subtype",
	"resource": {},
}

generate_disk_encryption_settings(type) = {"encryption": {
	"diskEncryptionSetId": "/subscriptions/dead-beef/resourceGroups/RESOURCEGROUP/providers/Microsoft.Compute/diskEncryptionSets/double-disk-encryption-set",
	"type": type,
}}

generate_attached_disk_with_encryption(settings) = generate_disk_with_encryption("Attached", settings)

generate_unattached_disk_with_encryption(settings) = generate_disk_with_encryption("Unattached", settings)

generate_disk_with_encryption(state, settings) = {
	"type": "azure-disk",
	"subType": "",
	"resource": {
		"id": "/subscriptions/dead-beef/resourceGroups/resourceGroup/providers/Microsoft.Compute/disks/unattached-disk",
		"location": "eastus",
		"name": "unattached-disk",
		"properties": object.union(
			{
				"creationData": {"createOption": "Empty"},
				"dataAccessAuthMode": "None",
				"diskIOPSReadWrite": 500,
				"diskMBpsReadWrite": 60,
				"diskSizeBytes": 4294967296,
				"diskSizeGB": 4,
				"diskState": state,
				"networkAccessPolicy": "DenyAll",
				"provisioningState": "Succeeded",
				"publicNetworkAccess": "Disabled",
				"timeCreated": "2023-09-28T19:05:41.631Z",
				"uniqueId": "12345-abcdef",
			},
			settings,
		),
		"resource_group": "resourceGroup",
		"subscription_id": "dead-beef",
		"tenant_id": "beef-dead",
		"type": "microsoft.compute/disks",
	},
}

generate_storage_account_with_property(key, value) = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {key: value}},
}

generate_azure_asset(type, properties) = {
	"type": type,
	"subType": "",
	"resource": {"properties": properties},
}

not_eval_storage_account_empty = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {}},
}

not_eval_non_exist_type = {
	"type": "azure-non-exist",
	"subType": "",
	"resource": {"properties": {}},
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

generate_activity_log_alerts_no_alerts = {
	"type": "azure-activity-log-alert",
	"subType": "",
	"resource": [],
}

generate_activity_log_alerts(rules) = {
	"type": "azure-activity-log-alert",
	"subType": "",
	"resource": rules,
}

generate_activity_log_alert(operation_name, category) = {
	"id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/activityLogAlerts/providers/microsoft.insights/activityLogAlerts/activityLogAlert",
	"type": "microsoft.insights/activitylogalerts",
	"kind": "activityLogAlert",
	"name": "activityLogAlert",
	"location": "global",
	"resourceGroup": "activityLogAlerts",
	"subscriptionId": "00000000-0000-0000-0000-000000000000",
	"managedBy": "",
	"properties": {
		"description": "",
		"enabled": true,
		"condition": {"allOf": [
			{
				"equals": category,
				"field": "category",
			},
			{
				"equals": operation_name,
				"field": "operationName",
			},
		]},
		"actions": {"actionGroups": []},
		"scopes": ["/subscriptions/00000000-0000-0000-0000-000000000000"],
	},
}
