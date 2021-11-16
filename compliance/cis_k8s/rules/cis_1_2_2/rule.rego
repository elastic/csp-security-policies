package compliance.cis_k8s.rules.cis_1_2_2

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --basic-auth-file argument is not set (Automated)
finding = result {
	command_args := data_adapter.command_args
	rule_evaluation := contains(command_args, "-basic-auth-file")

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
		"rule_name": "Ensure that the --basic-auth-file argument is not set",
		"tags": array.concat(cis_k8s.default_tags, ["CIS 1.2.2"]),
	}
}
