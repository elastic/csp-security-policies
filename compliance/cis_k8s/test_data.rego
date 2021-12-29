package cis_k8s.test_data

# test data generater

# genrates `file-system` type input data
filesystem_input(filename, mode, uid, gid) = {
	"type": "file-system",
	"resource": {
		"path": sprintf("file/path/%s", [filename]),
		"filename": filename,
		"mode": mode,
		"uid": uid,
		"gid": gid,
	},
}

# genrates `process` type input data
process_input(process_name, arguments) = {
	"type": "process",
	"resource": {"command": concat(" ", array.concat([process_name], arguments))},
}
