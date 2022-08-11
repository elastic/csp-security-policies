package compliance.cis_k8s.rules.cis_1_2_19

import data.compliance.policy.process.ensure_arguments_contain_key as audit

finding = result {
	result := audit.finding(audit.contains("--audit-log-path"))
}
