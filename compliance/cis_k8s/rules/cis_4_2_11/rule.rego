package compliance.cis_k8s.rules.cis_4_2_11

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

# Verify that the --rotate-certificates argument is not present, or is set to true.
rule_evaluation = false {
	common.contains_key_with_value(process_args, "--rotate-certificates", "false")
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation = false {
	not process_args["--rotate-certificates"]
	data_adapter.process_config.config.rotateCertificates == false
}

# Ensure that the --hostname-override argument is not set.
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
	"name": "Ensure that the --rotate-certificates argument is not set to false",
	"description": "Enable kubelet client certificate rotation.",
	"rationale": `The --rotate-certificates setting causes the kubelet to rotate its client certificates by creating new CSRs as its existing credentials expire.
This automated periodic rotation ensures that the there is no downtime due to expired certificates and thus addressing availability in the CIA security triad.
Note: This recommendation only applies if you let kubelets get their certificates from the API server.
In case your kubelet certificates come from an outside authority/tool (e.g.Vault) then you need to take care of rotation yourself.
Note: This feature also require the RotateKubeletClientCertificate feature gate to be enabled (which is the default since Kubernetes v1.7)`,
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.11", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `If using a Kubelet config file, edit the file to add the line rotateCertificates: true or remove it altogether to use the default value.
If using command line arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and remove --rotate-certificates=false argument from the KUBELET_CERTIFICATE_ARGS variable.
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default, kubelet client certificate rotation is enabled.",
}
