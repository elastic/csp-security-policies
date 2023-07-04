package cis_gcp.test_data

generate_kms_resource(members, rotationPeriod, nextRotationTime) = {
	"resource": {
		"asset_resource": {"data": {
			"nextRotationTime": nextRotationTime,
			"rotationPeriod": rotationPeriod,
		}},
		"iam_policy": {"bindings": [{
			"role": "roles/cloudkms.cryptoKeyEncrypterDecrypter",
			"members": members,
		}]},
	},
	"type": "key-management",
	"subType": "gcp-kms",
}

generate_gcs_resource(isBucketLevelAccessEnabled) = {
	"resource": {
		"asset_resource": {"data": {"iamConfiguration": {"uniformBucketLevelAccess": {"enabled": isBucketLevelAccessEnabled}}}},
		"iam_policy": {},
	},
	"type": "cloud-storage",
	"subType": "gcp-gcs",
}

generate_bq_table(kmsKeyName) = {
	"resource": {
		"asset_resource": {"data": {"defaultEncryptionConfiguration": {"kmsKeyName": kmsKeyName}}},
		"iam_policy": {},
	},
	"type": "cloud-storage",
	"subType": "gcp-bq-table",
}

generate_bq_dataset(kmsKeyName) = {
	"resource": {
		"asset_resource": {"data": {"defaultEncryptionConfiguration": {"kmsKeyName": kmsKeyName}}},
		"iam_policy": {},
	},
	"type": "cloud-storage",
	"subType": "gcp-bq-dataset",
}

not_eval_resource = {
	"resource": {},
	"type": "key-management",
	"subType": "no-exisitng-type",
}
