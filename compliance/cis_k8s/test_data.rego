package cis_k8s.test_data

# test data generater

opa_test_id := "8910"

# generates `file-system` type input data
filesystem_input(filename, mode, uid, gid) = {
	"type": "file-system",
	"resource": {
		"id": opa_test_id,
		"data": {
			"path": sprintf("file/path/%s", [filename]),
			"filename": filename,
			"mode": mode,
			"uid": uid,
			"gid": gid,
		},
	},
}

# genrates `process` type input data
process_input(process_name, arguments) = {
	"type": "process",
	"resource": {
		"id": opa_test_id,
		"data": {"command": concat(" ", array.concat([process_name], arguments))},
	},
}

kube_api_input(resource) = {
	"type": "kube-api",
	"resource": {"id": opa_test_id, "data": resource},
}
