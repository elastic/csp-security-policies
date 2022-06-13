package server

import (
	"net/http"

	"github.com/elastic/csp-security-policies/bundle"
)

func HostCISKubernetes(path string) (http.Handler, error) {
	server := bundle.NewServer()
	err := bundle.HostBundle(path, bundle.CISKubernetesBundle())
	if err != nil {
		return nil, err
	}

	return server, nil
}
