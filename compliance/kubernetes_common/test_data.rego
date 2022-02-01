package kubernetes_common.test_data

# test data generater

dummy_id := "8910"

# generates `file-system` type input data
filesystem_input(filename, mode, uid, gid) = {
	"type": "file-system",
	"resource": {
		"id": dummy_id,
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
		"id": dummy_id,
		"data": {"command": concat(" ", array.concat([process_name], arguments))},
	},
}

kube_api_input(resource) = {
	"type": "kube-api",
	"resource": {"id": dummy_id, "data": resource},
}
