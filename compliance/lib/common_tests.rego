package compliance.lib.common

import data.compliance.cis_k8s.output_validations
import data.compliance.lib.assert

test_validate_metadata_invalid {
	invalid_metadata := {
		"name": "rule name",
		"description": "rule description",
		"impact": "rule impact",
		"tags": ["tag 1", "tag 2"],
		"benchmark": "benchmark name-version",
		"Remediation": "rule remidiation", # <- capitalized. should be "remediation"
	}

	not output_validations.validate_metadata(invalid_metadata)
}

test_validate_metadata_valid {
	metadata := {
		"name": "rule name",
		"description": "rule description",
		"impact": "rule impact",
		"tags": ["tag 1", "tag 2"],
		"benchmark": "benchmark name-version",
		"remediation": "rule remidiation",
	}

	output_validations.validate_metadata(metadata)
}
