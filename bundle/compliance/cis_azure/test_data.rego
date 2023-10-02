package cis_azure.test_data

generate_storage_account_with_property(key, value) = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {key: value}},
}

not_eval_storage_account_empty = {
	"type": "azure-storage-account",
	"subType": "",
	"resource": {"properties": {}},
}
