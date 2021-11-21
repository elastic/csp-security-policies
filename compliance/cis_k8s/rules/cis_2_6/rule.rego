package compliance.cis_k8s.rules.cis_2_6

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the --peer-auto-tls argument is not set to true (Automated)

# Verify that if the --peer-auto-tls argument exists, it is not set to true
command_args := data_adapter.etcd_args

no_violation {
	not common.array_contains(command_args, "--peer-auto-tls")
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
	"name": "Ensure that the --peer-auto-tls argument is not set to true",
	"description": "Do not use automatically generated self-signed certificates for TLS connections between peers.",
	"impact": "All peers attempting to communicate with the etcd server will require a valid client certificate for authentication.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 2.6", "etcd"]),
	"benchmark": cis_k8s.benchmark_name,
	"remediation": "Edit the etcd pod specification file /etc/kubernetes/manifests/etcd.yaml on the master node and either remove the --peer-auto-tls parameter or set it to false.",
}
