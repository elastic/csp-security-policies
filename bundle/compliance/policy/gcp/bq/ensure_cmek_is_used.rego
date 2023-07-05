package compliance.policy.gcp.bq.ensure_cmek_is_used

import data.compliance.policy.gcp.data_adapter

default is_cmek_used = false

is_cmek_used {
	not data_adapter.resource.data.defaultEncryptionConfiguration == null
	not count(data_adapter.resource.data.defaultEncryptionConfiguration) == 0
	not data_adapter.resource.data.defaultEncryptionConfiguration.kmsKeyName == ""
}
