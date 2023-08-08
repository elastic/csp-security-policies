package compliance.policy.gcp.data_adapter

import data.compliance.lib.common

resource = input.resource.resource

iam_policy = input.resource.iam_policy

has_policy = common.contains_key(input.resource, "iam_policy")

is_api_key {
	input.subType == "gcp-apikeys-key"
}

is_storage_bucket {
	input.subType == "gcp-storage-bucket"
}

is_iam_service_account {
	input.subType == "gcp-iam-service-account"
}

is_iam_service_account_key {
	input.subType == "gcp-iam-service-account-key"
}

is_cloudkms_crypto_key {
	input.subType == "gcp-cloudkms-crypto-key"
}

is_bigquery_dataset {
	input.subType == "gcp-bigquery-dataset"
}

is_bigquery_table {
	input.subType == "gcp-bigquery-table"
}

is_compute_instance {
	input.subType == "gcp-compute-instance"
}

is_cloud_sql {
	input.subType == "gcp-sql-instance"
}

is_sql_server {
    startswith(resource.data.databaseVersion, "SQLSERVER")
}