package compliance.cis_k8s.rules.cis_1_2_25

import data.compliance.policy.process.ensure_arguments_contain_key as audit

finding = result {
	result := audit.finding(audit.contains("--service-account-key-file"))
}
