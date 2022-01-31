package main

import data.compliance.cis_k8s
import data.compliance.lib.common

# input is a resource
# data is policy/configuration
# output is findings

resource = input.resource

# iterating over all the benchmarks and aggregate all findings
findings := [finding | data.compliance[benchmark].findings[finding]]

metadata = common.metadata
