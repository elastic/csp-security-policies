package main

import data.compliance
import data.compliance.lib.common

# input is a resource
# data is policy/configuration
# output is findings

resource = input.resource

findings = f {
	data.activated_rules

	# iterate over activated benchmarks
	benchmarks := [key | data.activated_rules[key]]

	rego := compliance

	# aggregate findings from activated benchmarks
	f := [finding | rego[benchmarks[_]].findings[finding]]
}

findings = f {
	not data.activated_rules

	rego := compliance

	# aggregate findings from all benchmarks
	f := [finding | rego[benchmarks].findings[finding]]
}

metadata = common.metadata
