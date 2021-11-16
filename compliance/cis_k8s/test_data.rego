package cis_k8s.test_data

# test data generater

filesystem_input(filename, mode, uid, gid) = {
	"type": "filesystem",
	"path": "file/path",
	"filename": filename,
	"mode": mode,
	"uid": uid,
	"gid": gid,
}

# Recivies an array of arguments representing the API Server command
api_server_input(arguments) = {
	"type": "api_server",
	"command": concat(" ", array.concat(["kube-apiserver --allow-privileged=true"], arguments)),
}
