package server

import (
	"net/http"

	"github.com/elastic/csp-security-policies/bundle"
)

func HostCISKubernetes(path string) (http.Handler, error) {
	policies := bundle.CISKubernetes()
	server := bundle.NewServer()
	err := server.HostBundle(path, policies)
	if err != nil {
		return nil, err
	}

	return server, nil
}
