package compliance.lib.output_validations

import data.compliance
import future.keywords.every

validate_metadata(metadata) {
	metadata.id
	metadata.name
	metadata.profile_applicability
	metadata.description
	metadata.rationale 
  	metadata.audit 
  	metadata.remediation
	metadata.impact
	metadata.default_value
	metadata.references
	metadata.section
	metadata.version
	metadata.tags
	metadata.benchmark
	metadata.benchmark.name
	metadata.benchmark.version
} else = false {
	true
}

# validate every rule metadata
test_validate_rule_metadata {
	all_rules := [rule | rule := compliance[benchmark].rules[rule_id]]

	every rule in all_rules {
		validate_metadata(rule.metadata)
	}
}
