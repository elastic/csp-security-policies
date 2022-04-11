package compliance.cis_k8s.rules.cis_4_2_13

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

default rule_evaluation = true

process_args := cis_k8s.data_adapter.process_args

supported_ciphers = [
	"TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
	"TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305","TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
	"TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305","TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
	"TLS_RSA_WITH_AES_256_GCM_SHA384","TLS_RSA_WITH_AES_128_GCM_SHA256",
]

# Verify that the RotateKubeletServerCertificate argument is set to true
rule_evaluation = false {
	ciphers := split(process_args["--tls-cipher-suites"], ",")
	print(ciphers)
	cipher := ciphers[_]
	not is_supported_cipher(cipher)
}

# In case both flags and configuration file are specified, the executable argument takes precedence.
rule_evaluation = false {
	not process_args["--tls-cipher-suites"]
	ciphers := data_adapter.process_config.config.TLSCipherSuites
	cipher := ciphers[_]
	not is_supported_cipher(cipher)
}

is_supported_cipher(cipher) {
	supported_ciphers[_] == cipher
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
	"name": "Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers",
	"description": "Ensure that the Kubelet is configured to only use strong cryptographic ciphers.",
	"rationale": `TLS ciphers have had a number of known vulnerabilities and weaknesses, which can reduce the protection provided by them.
By default Kubernetes supports a number of TLS ciphersuites including some that have security concerns, weakening the protection provided.`,
	"impact": "Kubelet clients that cannot support modern cryptographic ciphers will not be able to make connections to the Kubelet API.",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.2.13", "Kubelet"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": `If using a Kubelet config file, edit the file to set TLSCipherSuites: to
TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 ,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 ,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 ,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256 or to a subset of these values.
If using executable arguments, edit the kubelet service file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and set the --tls-cipher-suites parameter as follows, or to a subset of these values.
--tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service`,
	"default_value": "By default the Kubernetes API server supports a wide range of TLS ciphers",
}
