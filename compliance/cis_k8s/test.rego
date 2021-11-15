package cis_k8s.test

rule_pass(finding) {
	finding.evaluation == "passed"
}

rule_violation(finding) {
	finding.evaluation == "violation"
}

generate_filesystem_input(filename, mode, uid, gid) = {
	"type": "filesystem",
	"path": "file/path",
	"filename": filename,
	"mode": mode,
	"uid": uid,
	"gid": gid,
}
