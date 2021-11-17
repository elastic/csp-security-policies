# Cloud Security Posture security policies 
    .
    ├── compliance                         # Compliance policies
    │   ├── lib
    │   │   ├── common.rego                # Common functions
    │   │   ├── data_adapter.rego          # Input data adapter
    │   │   └── test.rego                  # Common Test functions
    │   ├── cis_k8s
    │   |   ├── cis_k8s.rego               # Handles all Kubernetes CIS rules evalutations
    │   |   ├── test_data.rego             # CIS Test data functions
    │   │   ├── rules
    │   │   │   ├── cis_1_1_1                  # CIS 1.1.1 rule package 
    │   │   │   │   ├── rule.rego
    │   │   │   │   └── test.rego
    │   │   │   └── ...
    └── main.rego                          # Evaluate all policies and returns the findings
    
## Local Evaluation
Add the following configuration files into the root folder
##### `data.yaml`
should contain the list of rules you want to evaluate (also supports json)

```yaml
activated_rules:
  cis_k8s:
    cis_1_1_1: true
    cis_1_1_2: true
```

##### `input.json`
should contain an beat/agent output, e.g. filesystem data

```json
{
    "type": "filesystem",
    "mode": "0700",
    "path": "/hostfs/etc/kubernetes/manifests/kube-apiserver.yaml",
    "uid": "etc",
    "filename": "kube-apiserver.yaml",
    "gid": "root"
}
```

### Evaluate entire policy into output.json
`opa eval data.main --format pretty -i input.json -b . > output.json`

### Evaluate findings only
`opa eval data.main.findings --format pretty -i input.json -b . > output.json`

<details> 
<summary>Example output</summary>
  
```json
{
  "findings": [
    [
      {
        "evaluation": "violation",
        "evidence": {
          "filemode": "0700"
        },
        "remediation": "chmod 644 /hostfs/etc/kubernetes/manifests/kube-apiserver.yaml",
        "tags": [
          "CIS",
          "CIS v1.6.0",
          "Kubernetes",
          "CIS 1.1.1",
          "Master Node Configuration"
        ]
      },
      {
        "rule_metadata": {
          "benchmark": "CIS Kubernetes",
          "description": "The API server pod specification file controls various parameters that set the behavior of the API server. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.",
          "impact": "None",
          "name": "Ensure that the API server pod specification file permissions are set to 644 or more restrictive",
          "tags": [
            "CIS 1.1.1",
            "Master Node Configuration"
          ],
          "version": "Version 6"
        }
      }
    ],
    [
      {
        "evaluation": "passed",
        "evidence": {
          "gid": "root",
          "uid": "root"
        },
        "remediation": "chown root:root /hostfs/etc/kubernetes/manifests/kube-apiserver.yaml",
        "tags": [
          "CIS",
          "CIS v1.6.0",
          "Kubernetes",
          "CIS 1.1.2",
          "Master Node Configuration"
        ]
      },
      {
        "rule_metadata": {
          "benchmark": "CIS Kubernetes",
          "description": "The API server pod specification file controls various parameters that set the behavior of the API server. You should set its file ownership to maintain the integrity of the file. The file should be owned by root:root.",
          "impact": "None",
          "name": "Ensure that the API server pod specification file ownership is set to root:root",
          "tags": [
            "CIS 1.1.2",
            "Master Node Configuration"
          ],
          "version": "Version 6"
        }
      }
    ]
  ],
  "resource": {
    "filename": "kube-apiserver.yaml",
    "gid": "root",
    "mode": "0700",
    "path": "/hostfs/etc/kubernetes/manifests/kube-apiserver.yaml",
    "type": "filesystem",
    "uid": "root"
  }
}



```
  
</details>

## Local Testing
### Test entire policy
`opa test -v compliance`

### Test specific rule
`opa test -v compliance/lib compliance/cis_k8s.rego compliance/rules/cis_1_1_2`

### Pre-commit hooks
see [pre-commit](https://pre-commit.com/) package

- Install the package `brew install pre-commit`
- Then run `pre-commit install`
- Finally `pre-commit run --all-files --verbose`
