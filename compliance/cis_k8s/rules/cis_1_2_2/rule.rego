package compliance.cis_k8s.rules.cis_1_2_2

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --basic-auth-file argument is not set (Automated)
finding = result {
	command_args := data_adapter.command_args
	rule_evaluation := contains(command_args, "--basic-auth-file") == false

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
		"tags": array.concat(cis_k8s.default_tags, metadata.tags),
	}
}

metadata = {
	"rule_name": "Ensure that the --basic-auth-file argument is not set",
	"tags": ["CIS 1.2.2", "API Server"],
}
