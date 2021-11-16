package compliance.cis_k8s

import data.compliance.cis_k8s.rules

default_tags := ["CIS", "CIS v1.6.0", "Kubernetes"]

findings[{finding, metadata}] {
	some rule_id
	data.activated_rules.cis_k8s[rule_id]
	finding = rules[rule_id].finding
	metadata = {"rule_metadata": rules[rule_id].metadata}
}
