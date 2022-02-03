package compliance.lib.output_validations

import data.compliance.lib.assert

validate_metadata(metadata) {
	metadata.name
	metadata.description
	metadata.impact
	metadata.tags
	metadata.benchmark
	metadata.remediation
} else = false {
	true
}

