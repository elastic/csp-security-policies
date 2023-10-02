package compliance.policy.azure.data_adapter

# import data.compliance.lib.common

resource = input.resource

properties = resource.properties

is_disk {
	input.type == "azure-disk"
}

is_unattached_disk {
	is_disk
	properties.diskState == "Unattached"
}

is_storage_account {
	input.type == "azure-storage-account"
}
