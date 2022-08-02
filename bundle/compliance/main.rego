package main

import data.compliance
import data.compliance.lib.common

# input contains the resource and the configuration
# output is findings

resource = input.resource

activated_rules = input.activated_rules

findings = f {
	activated_rules

	# iterate over activated benchmarks
	benchmarks := [key | activated_rules[key]]

	# aggregate findings from activated benchmarks
	f := {finding | compliance[benchmarks[_]].findings[finding]}
}

findings = f {
	not activated_rules

	# aggregate findings from all benchmarks
	f := {finding | compliance[benchmarks].findings[finding]}
}

metadata = common.metadata
