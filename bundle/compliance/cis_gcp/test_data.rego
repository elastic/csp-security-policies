package cis_gcp.test_data

generate_kms_resource(members) = {
	"resource": {},
	"iam_policy": {"bindings": [{
		"role": "roles/cloudkms.cryptoKeyEncrypterDecrypter",
		"members": members,
	}]},
	"type": "key-management",
	"subType": "gcp-kms",
}

not_eval_resource = {
	"resource": {},
	"type": "key-management",
	"subType": "no-exisitng-type",
}
