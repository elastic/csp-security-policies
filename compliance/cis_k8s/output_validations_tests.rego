package compliance.cis_k8s.output_validations

import data.compliance.cis_k8s.rules
import data.compliance.lib.output_validations

# validate every rule metadata
test_validate_rule_metadata {
	valid_rules := {rule_id | output_validations.validate_metadata(rules[rule_id].metadata)}
	count(valid_rules) == count(rules)
}
