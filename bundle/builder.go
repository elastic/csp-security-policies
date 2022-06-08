package bundle

import (
	"bytes"
	"context"
	"io/fs"
	"testing/fstest"

	layerfs "github.com/dschmidt/go-layerfs"
	opaBundle "github.com/open-policy-agent/opa/bundle"
	opaCompile "github.com/open-policy-agent/opa/compile"
)

func Build(fs fs.FS) ([]byte, error) {

	buf := bytes.NewBuffer(nil)

	b, err := createBundle(fs)
	if err != nil {
		return nil, err
	}

	compiler := opaCompile.New().
		WithBundle(&b).
		WithOutput(buf)

	err = compiler.Build(context.Background())
	if err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
	
}

func createBundle(fs fs.FS) (opaBundle.Bundle, error) {
	loader, err := opaBundle.NewFSLoader(fs)
	if err != nil {
		return opaBundle.Bundle{}, err
	}

	reader := opaBundle.NewCustomReader(loader)

	b, err := reader.Read()
	if err != nil {
		return opaBundle.Bundle{}, err
	}

	return b, nil
}

func CISKubernetesFS() fs.FS {
	return layerfs.New(CommonEmbed, CISRulesEmbed)
}

func CISEksFS() fs.FS {
	return layerfs.New(CommonEmbed, EKSRulesEmbed)
}

func MergedFSWithDataYaml(fs fs.FS, dataYaml string) fs.FS {
	yamlFS := fstest.MapFS{
		"data.yaml": {
			Data: []byte(dataYaml),
		},
	}
	return layerfs.New(yamlFS, fs)
}
