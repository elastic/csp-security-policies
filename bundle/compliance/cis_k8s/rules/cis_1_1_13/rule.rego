package compliance.cis_k8s.rules.cis_1_1_13

import data.compliance.policy.audit.file.ensure_permissions as audit

finding = result {
	audit.filename_filter("admin.conf")
	result := audit.finding(6, 0, 0)
}
