package cis_aws.test_data

generate_password_policy(pwd_len, reuse_count) = {
	"resource": {
		"MaxAgeDays": 90,
		"MinimumLength": pwd_len,
		"RequireLowercase": true,
		"RequireNumbers": true,
		"RequireSymbols": true,
		"RequireUppercase": true,
		"ReusePreventionCount": reuse_count,
	},
	"type": "identity-management",
	"subType": "aws-password-policy",
}

not_evaluated_input = {
	"type": "some type",
	"subType": "some sub type",
	"resource": {
		"MaxAgeDays": 90,
		"MinimumLength": 8,
		"RequireLowercase": true,
		"RequireNumbers": true,
		"RequireSymbols": true,
		"RequireUppercase": true,
		"ReusePreventionCount": 5,
	},
}

generate_iam_user(access_keys, mfa_devices, has_logged_in, last_access) = {
	"type": "identity-management",
	"subType": "aws-iam-user",
	"resource": {
		"Name": "test",
		"AccessKeys": access_keys,
		"MFADevices": mfa_devices,
		"LastAccess": last_access,
		"HasLoggedIn": has_logged_in,
		"Arn": "arn:aws:iam::704479110758:user/test",
	},
}

future_date = "2040-08-22 14:19:32 +0000 UTC"

past_date = "2021-08-22 14:19:32 +0000 UTC"
