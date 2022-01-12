package bundle

import (
	"io/fs"
	"os"
	"strings"

	policy "github.com/elastic/csp-security-policies/compliance"
)

func CISKubernetes() (map[string]string, error) {
	filePrefixes := []string{
		"main.rego",
		"lib/",
		"cis_k8s/",
	}

	return createPolicyMap(policy.Embed, filePrefixes)
}

func createPolicyMap(fsys fs.FS, filePrefixes []string) (map[string]string, error) {
	policies := make(map[string]string)

	err := fs.WalkDir(fsys, ".", func(filePath string, info os.DirEntry, err error) error {
		if err != nil {
			return err
		}

		include := !info.IsDir() && includeFile(filePrefixes, filePath)
		if !include {
			return nil
		}

		data, err := fs.ReadFile(fsys, filePath)
		if err != nil {
			return err
		}

		policies[filePath] = string(data)
		return nil
	})

	return policies, err
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
