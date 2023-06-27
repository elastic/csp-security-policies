package compliance.policy.gcp.kms.ensure_no_public_key

import future.keywords.if

default key_is_public = false

key_is_public if {
	some i, j
	input.iam_policy.bindings[i].members[j] == "allUsers"
}

key_is_public if {
	some i, j
	input.iam_policy.bindings[i].members[j] == "allAuthenticatedUsers"
}
