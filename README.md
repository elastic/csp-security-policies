# csp-security-policies
Cloud Security Posture security policies 

### Evaluate entire policy into output.json
`opa eval --format pretty -i input.json -d main.rego -b . data.main > output.json`

### Evaluate findings only
`opa eval --format pretty -i input.json -d main.rego -b . data.main.findings > output.json`
