package cis_k8s.test_data

# test data generater

testid := "8910"

# generates `file-system` type input data
filesystem_input(filename, mode, uid, gid) = {
	"type": "file-system",
	"resource": {
		"id": testid,
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
		"id": testid,
		"data": {"command": concat(" ", array.concat([process_name], arguments))},
	},
}

kube_api_input(resource) = {
	"type": "kube-api",
	"resource": {"id": testid, "data": resource},
}
