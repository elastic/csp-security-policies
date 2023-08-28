package compliance.policy.azure.storage_account.ensure_encryption

import data.compliance.policy.azure.data_adapter

default is_encryption_enabled = false

is_encryption_enabled {
	data_adapter.properties.encryption.requireInfrastructureEncryption
}
