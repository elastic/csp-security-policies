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
