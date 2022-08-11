package compliance.cis_k8s.rules.cis_1_2_26

import data.compliance.policy.process.ensure_appropriate_arguments as audit

finding = result {
	result := audit.finding([
		"--etcd-certfile",
		"--etcd-keyfile",
	])
}
