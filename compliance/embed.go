package policy

import "embed"

//go:embed compliance
//go:embed main.rego
var Embed embed.FS
