# csp-security-policies
Cloud Security Posture security policies 

eval entire policy into output.json
opa eval --format pretty -i input.json -d main.rego -b . data.main > output.json

eval findings
opa eval --format pretty -i input.json -d main.rego -b . data.main.findings > output.json