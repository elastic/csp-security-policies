package compliance.cis.rules.cis_1_1_1

import data.compliance.lib.osquery

finding = {"message": msg, "tags": tags, "result": result} {
    osquery.filename == "kube-apiserver.yaml"
    filemode := osquery.filemode
    pattern := "0?(0|1|2|3|4|5|6)(0|1|2|3|4)(0|1|2|3|4)"
    # not regex.match(pattern, filemode)
    result := calculate_result(false)
    msg := "Ensure that the API server pod specification file permissions are set to 644 or more restrictive (Automated)"
    tags := ["cis", "cis 1.1.1", "kubernetes"]
}

calculate_result(passed) = "passed" {
    passed
} else = "violation"