package cis_gcp.test_data

generate_kms_resource(members, rotationPeriod, nextRotationTime, primary) = {
	"resource": {"asset": {
		"resource": {"data": {
			"nextRotationTime": nextRotationTime,
			"rotationPeriod": rotationPeriod,
			"primary": primary,
		}},
		"iam_policy": {"bindings": [{
			"role": "roles/cloudkms.cryptoKeyEncrypterDecrypter",
			"members": members,
		}]},
	}},
	"type": "key-management",
	"subType": "gcp-kms",
}

generate_gcs_resource(isBucketLevelAccessEnabled) = {
	"resource": {"asset": {
		"resource": {"data": {"iamConfiguration": {"uniformBucketLevelAccess": {"enabled": isBucketLevelAccessEnabled}}}},
		"iam_policy": {},
	}},
	"type": "cloud-storage",
	"subType": "gcp-gcs",
}

generate_bq_resource(config, subType) = {
	"resource": {"asset": {
		"resource": {"data": {"defaultEncryptionConfiguration": config}},
		"iam_policy": {},
	}},
	"type": "cloud-storage",
	"subType": subType,
}

not_eval_resource = {
	"resource": {},
	"type": "key-management",
	"subType": "no-exisitng-type",
}
