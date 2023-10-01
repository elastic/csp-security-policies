package cis_azure.test_data

not_eval_resource = {
	"type": "azure-resource",
	"subType": "",
	"resource": {},
}

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

generate_activity_log_alerts_no_alerts = {
	"type": "azure-activity-log-alerts",
	"subType": "",
	"resource": {"activity_log_alerts": []},
}

generate_activity_log_alerts(rules) = {
	"type": "azure-activity-log-alerts",
	"subType": "",
	"resource": {"activity_log_alerts": rules},
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
