package compliance.policy.gcp.kms.ensure_no_public_key

import data.compliance.policy.gcp.kms.data_adapter
import future.keywords.if

default key_is_public = false

key_is_public if {
	# Check if the IAM policy is not empty
	not count(data_adapter.iam_policy) == 0
	some i, j
	data_adapter.iam_policy.bindings[i].members[j] == "allUsers"
}

key_is_public if {
	# Check if the IAM policy is not empty
	not count(data_adapter.iam_policy) == 0
	some i, j
	data_adapter.iam_policy.bindings[i].members[j] == "allAuthenticatedUsers"
}
