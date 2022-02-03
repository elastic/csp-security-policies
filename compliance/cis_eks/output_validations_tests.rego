package compliance.cis_eks_output_validations

import data.compliance.cis_eks.rules
import data.compliance.lib.output_validations

# validate every rule metadata
test_validate_rule_metadata {
	valid_rules := {rule_id | output_validations.validate_metadata(rules[rule_id].metadata)}
	count(valid_rules) == count(rules)
}
