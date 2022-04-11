package compliance.cis_k8s.rules.cis_4_2_12

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = false

process_args := cis_k8s.data_adapter.process_args

# Verify that the RotateKubeletServerCertificate argument is set to true
rule_evaluation {
	common.contains_key_with_value(process_args, "--feature-gates", "RotateKubeletServerCertificate=true")
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation {
	not process_args["--feature-gates"]
	data_adapter.process_config.config.featureGates.RotateKubeletServerCertificate
}

rule_evaluation {
	not contains(process_args["--feature-gates"], "RotateKubeletServerCertificate")
	data_adapter.process_config.config.featureGates.RotateKubeletServerCertificate
}

rule_evaluation {
    common.contains_key_with_value(process_args,"--rotate-server-certificates", "true")
}

rule_evaluation {
    data_adapter.process_config.config.serverTLSBootstrap
}

# Verify that the RotateKubeletServerCertificate argument is set to true
finding = result {
	# filter
	data_adapter.is_kubelet

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {
			"process_args": process_args,
			"process_config": data_adapter.process_config,
		},
	}
}

metadata = {
	"name": "Verify that the RotateKubeletServerCertificate argument is set to true",
	"description": "Enable kubelet server certificate rotation.",
	"rationale": `RotateKubeletServerCertificate causes the kubelet to both request a serving certificateafter bootstrapping its client credentials and rotate the certificate as its existing credentialsexpire.
This automated periodic rotation ensures that the there are no downtimes due to expired certificates and thus addressing availability in the CIA security triad.
Note: This recommendation only applies if you let kubelets get their certificates from the API server.
In case your kubelet certificates come from an outside authority/tool (e.g. Vault) then you need to take care of rotation yourself.`,
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.12", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `Edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the below parameter in KUBELET_CERTIFICATE_ARGS variable.
--feature-gates=RotateKubeletServerCertificate=true
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default, kubelet server certificate rotation is disabled.",
}
