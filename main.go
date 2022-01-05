package main

import (
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/elastic/csp-security-policies/bundle"
)

const PoliciesRoot = "policy"

func main() {
	server, _ := HostCISKubernetes("bun.tar.gz")
	log.Fatal(http.ListenAndServe(":8000", server))
}

func CISKubernetes() map[string]string {
	filePrefixes := []string{
		"policy/main.rego",
		"policy/compliance/lib/",
		"policy/compliance/cis_k8s/",
	}

	return createPolicyMap(PoliciesRoot, filePrefixes)
}

func HostCISKubernetes(path string) (http.Handler, error) {
	policies := CISKubernetes()
	server := bundle.NewServer()
	err := server.HostBundle(path, policies)
	if err != nil {
		return nil, err
	}

	return server, nil
}

func createPolicyMap(root string, filePrefixes []string) map[string]string {
	policies := make(map[string]string)

	filepath.WalkDir(root, func(filePath string, info os.DirEntry, err error) error {
		if err != nil {
			return nil
		}

		include := !info.IsDir() && includeFile(filePrefixes, filePath)

		if include {
			data, err := os.ReadFile(filePath)
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
