package compliance.cis_eks.rules.cis_5_4_5

import data.compliance.cis_eks
import data.compliance.cis_eks.data_adatper
import data.compliance.lib.common

default rule_evaluation = true

# Verify that all listeners has SSL Certificate
rule_evaluation = false {
	input.resource.ListenerDescriptions[_].Listener.SSLCertificateId == null
}

# Verify that all listeners use https protocoal
rule_evaluation = false {
	input.resource.ListenerDescriptions[_].Listener.InstanceProtocol != "HTTPS"
}

# Ensure there Kuberenetes endpoint private access is enabled
finding = result {
	# filter
	data_adatper.is_aws_elb

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
	}
}

metadata = {
	"name": "Encrypt traffic to HTTPS load balancers with TLS certificates",
	"description": "Encrypt traffic to HTTPS load balancers using TLS certificates.",
	"rationale": `Encrypting traffic between users and your Kubernetes workload is fundamental to protecting data sent over the web.`,
	"remediation": "",
	"tags": array.concat(cis_eks.default_tags, ["CIS 5.4.5", "AWS Key Management Service (KMS)"]),
	"default_value": "",
	"benchmark": cis_eks.benchmark_name,
	"impact": "",
}
