package compliance.cis_aws.rules.cis_1_13

import data.compliance.lib.common
import data.compliance.policy.aws_iam.data_adapter

# Ensure that there is only a single active access key per user.
finding = result {
	# filter
	data_adapter.is_iam_user

    # aggregate active access keys
    active_access_keys := { access_key |
        access_key = data_adapter.iam_user.AccessKeys[_]
        access_key.Active == true
    }

	# set result
	result := common.generate_result_without_expected(
		common.calculate_result(count(active_access_keys) < 2),
		{"IAM User:": data_adapter.iam_user}
	)
}

