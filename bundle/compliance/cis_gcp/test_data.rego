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

not_eval_resource = {
	"resource": {},
	"type": "key-management",
	"subType": "no-exisitng-type",
}
