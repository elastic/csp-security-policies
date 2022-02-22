package compliance.cis_eks.rules.cis_5_4_1

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_private_access_disabled
	test.assert_fail(finding) with input as violating_input_private_access_enabled_but_unvalid_filter
	test.assert_fail(finding) with input as violating_input_private_access_enabled_and_one_filter_is_invalid
}

test_pass {
	test.assert_pass(finding) with input as non_violating_input
}

test_not_evaluated {
	not finding with input as test_data.not_evaluated_input
}

violating_input_private_access_disabled = test_data.generate_eks_input_with_vpc_config(false, true, ["0.0.0.0/0"])

violating_input_private_access_enabled_but_unvalid_filter = test_data.generate_eks_input_with_vpc_config(true, true, ["0.0.0.0/0"])

violating_input_private_access_enabled_and_one_filter_is_invalid = test_data.generate_eks_input_with_vpc_config(true, true, ["182.20.11.0/0", "0.0.0.0/0"])

non_violating_input = test_data.generate_eks_input_with_vpc_config(true, true, ["203.0.113.5/32"])
