package compliance.policy.gcp.kms.data_adapter

is_kms_key {
	input.subType == "gcp-kms"
}

resource = input.resource

iam_policy = object.get(input, "iam_policy", {})
