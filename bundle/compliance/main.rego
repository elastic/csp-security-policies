package main

import data.compliance
import data.compliance.lib.common

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.compliance.policy.gcp.types as gcptypes

# input contains the resource and the configuration
# output is findings
resource = input.resource

findings = f if {
	input.benchmark

	# iterate over activated benchmark rules
	benchmark := input.benchmark

	# aggregate findings from activated benchmark
	f := {finding |
		result := compliance[benchmark].rules[rule].finding with data.benchmark_data_adapter as compliance[benchmark].data_adapter
		finding = {
			"result": result,
			"rule": compliance[benchmark].rules[rule].metadata,
		}
	}
}

findings = f if {
	not input.benchmark

	# aggregate findings from all benchmarks
	f := {finding |
		result := compliance[benchmark].rules[rule].finding with data.benchmark_data_adapter as compliance[benchmark].data_adapter
		finding = {
			"result": result,
			"rule": compliance[benchmark].rules[rule].metadata,
		}
	}
}

metadata = common.metadata

# reports unknown subtype
errors contains error if {
	not input.subType in gcptypes.subtypes
	error := sprintf("unknown subtype: '%s'", [input.subType])
}
