package compliance

import "embed"

//go:embed lib
//go:embed cis_k8s
//go:embed main.rego
//go:embed cis_eks
//go:embed kubernetes_common
var Embed embed.FS
