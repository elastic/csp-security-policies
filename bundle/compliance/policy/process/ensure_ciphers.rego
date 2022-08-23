package compliance.policy.process.ensure_ciphers

import data.benchmark_data_adapter
import data.compliance.lib.common as lib_common
import data.compliance.policy.process.data_adapter

process_args := data_adapter.process_args(benchmark_data_adapter.process_args_seperator)

process_args_entity(entity) {
	process_args[entity]
}

is_strong_cryptographic_cipher_args(supported_ciphers) {
	ciphers := split(process_args["--tls-cipher-suites"], ",")
	cipher := ciphers[_]
	not is_supported_cipher(supported_ciphers, cipher)
}

is_strong_cryptographic_cipher_config(supported_ciphers) {
	not process_args["--tls-cipher-suites"]
	ciphers := data_adapter.process_config.config.TLSCipherSuites
	cipher := ciphers[_]
	not is_supported_cipher(supported_ciphers, cipher)
}

is_supported_cipher(supported_ciphers, cipher) {
	supported_ciphers[_] == cipher
}

finding(rule_evaluation) = result {
	# set result
	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation),
		{
			"process_args": process_args,
			"process_config": data_adapter.process_config,
		},
	)
}

apiserver_filter = data_adapter.is_kube_apiserver

kubelet_filter = data_adapter.is_kubelet
