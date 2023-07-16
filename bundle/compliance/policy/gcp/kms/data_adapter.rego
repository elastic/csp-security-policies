package compliance.policy.gcp.kms.data_adapter

is_kms_key {
	input.subType == "gcp-kms"
}

is_iam {
	input.subType == "gcp-iam"
}

is_bigquery {
	input.subType == "gcp-bigquery"
}

# Resource will always exists
resource = input.resource.asset.resource

iam_policy = object.get(input.resource.asset, "iam_policy", {})
