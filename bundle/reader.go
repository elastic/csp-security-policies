package bundle

import (
	"io/fs"
	"os"
	"strings"

	"github.com/elastic/csp-security-policies/policy"
)

func CISKubernetes() map[string]string {
	filePrefixes := []string{
		"main.rego",
		"compliance/lib/",
		"compliance/cis_k8s/",
	}

	return createPolicyMap(policy.Embed, filePrefixes)
}

func createPolicyMap(fsys fs.FS, filePrefixes []string) map[string]string {
	policies := make(map[string]string)

	fs.WalkDir(fsys, ".", func(filePath string, info os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		include := !info.IsDir() && includeFile(filePrefixes, filePath)

		if include {
			data, err := fs.ReadFile(fsys, filePath)
			if err == nil {
				policies[filePath] = string(data)
			}
		}
		return nil
	})

	return policies
}

func includeFile(filePrefixes []string, filePath string) bool {
	if !strings.HasSuffix(filePath, ".rego") {
		return false
	}

	if strings.HasSuffix(filePath, "test.rego") {
		return false
	}

	for _, p := range filePrefixes {
		matched := strings.HasPrefix(filePath, p)
		if matched {
			return true
		}
	}

	return false
}
