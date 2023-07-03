package compliance.policy.gcp.data_adapter

resource = input.resource.asset_resource

iam_policy = object.get(input.resource, "iam_policy", {})

is_gcs_bucket {
	input.subType == "gcp-gcs"
}

is_kms_key {
	input.subType == "gcp-kms"
}
