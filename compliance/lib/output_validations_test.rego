package compliance.lib.output_validations

import data.compliance

# validate every rule metadata
test_validate_rule_metadata {
	all_rules := compliance[benchmark].rules
	valid_rules := [rule | validate_metadata(compliance[benchmark].rules[rule].metadata)]
	count(valid_rules) == count(all_rules)
}
