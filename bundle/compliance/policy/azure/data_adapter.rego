package compliance.policy.azure.data_adapter

resource = input.resource

properties = resource.properties

activity_log_alerts = resource.activity_log_alerts

is_storage_account {
	input.type == "azure-storage-account"
}

is_activity_log_alerts {
	input.type == "azure-activity-log-alert"
}
