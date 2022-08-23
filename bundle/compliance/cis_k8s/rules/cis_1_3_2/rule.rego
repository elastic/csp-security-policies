package compliance.cis_k8s.rules.cis_1_3_2

import data.compliance.policy.process.ensure_arguments_contain_key_value as audit

finding = result {
	audit.controller_manager_filter
	result := audit.finding(audit.contains("--profiling", "false"))
}
