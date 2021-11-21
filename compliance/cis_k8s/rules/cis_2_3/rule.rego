package compliance.cis_k8s.rules.cis_2_3

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --auto-tls argument is not set to true (Automated)

# Verify that if the --auto-tls argument exists, it is not set to true.
command_args := data_adapter.etcd_args

no_violation {
	not common.array_contains(command_args, "--auto-tls")
}

# or
no_violation {
	common.array_contains(command_args, "--auto-tls=false")
}

default rule_evaluation = false

rule_evaluation {
	no_violation
}

finding = result {
	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"command_args": command_args},
	}
}

metadata = {
	"name": "Ensure that the --auto-tls argument is not set to true",
	"description": "Do not use self-signed certificates for TLS.",
	"impact": "Clients will not be able to use self-signed certificates for TLS.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 2.3", "etcd"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the etcd pod specification file /etc/kubernetes/manifests/etcd.yaml on the master node and either remove the --auto-tls parameter or set it to false. --auto-tls=false",
}
