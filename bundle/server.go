package bundle

import (
	"bytes"
	"net/http"
	"os"
	"path/filepath"

	"github.com/gorilla/mux"
)

const BundlesFolder = "tmpBundles"
const BundlePathPrefix = "/bundles/"

type Server struct {
	router *mux.Router
}

func NewServer() *Server {
	router := mux.NewRouter()
	router.PathPrefix(BundlePathPrefix).Handler(http.StripPrefix(BundlePathPrefix, http.FileServer(http.Dir(BundlesFolder))))

	return &Server{
		router: router,
	}
}

func (s *Server) HostBundle(name string, files map[string]string) error {
	if _, err := os.Stat(BundlesFolder); os.IsNotExist(err) {
		err := os.Mkdir(BundlesFolder, os.ModePerm)
		if err != nil {
			return err
		}
	}

	bundlePath := filepath.Join(BundlesFolder, name)
	file, err := os.Create(bundlePath)
	if err != nil {
		return err
	}

	writer := NewWriter(file)
	defer writer.Close()

	for k, v := range files {
		reader := bytes.NewReader([]byte(v))
		writer.AddFile(k, reader, int64(len(v)))
	}

	return nil
}

func (s *Server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	s.router.ServeHTTP(w, r)
}
