package cis_k8s.test_data

# test data generater
filesystem_input(filename, mode, uid, gid) = {
	"type": "file-system",
	"path": sprintf("file/path/%s", [filename]),
	"filename": filename,
	"mode": mode,
	"uid": uid,
	"gid": gid,
}

# Recivies an array of arguments representing the kube-controller-manager command
etcd_input(process_type, arguments) = {
	"type": process_type,
	"command": concat(" ", array.concat(["etcd"], arguments)),
}
