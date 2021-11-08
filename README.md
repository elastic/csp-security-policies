# Cloud Security Posture security policies 

## Local Evaluation
Add the following configuration files into the root folder
#### `data.yaml`
should contain the list of rules you want to evaluate (also supports json)

```yaml
activated_rules:
  cis_1_1_1: true
  cis_1_1_2: true
```

#### `input.json`
should contain an beat/agent output, e.g. OSQuery

```json
{
  "osquery": {
    "mode": "0700",
    "path": "/hostfs/etc/kubernetes/manifests/kube-apiserver.yaml",
    "uid": "etc",
    "filename": "kube-apiserver.yaml",
    "gid": "root"
  }
}
```

### Evaluate entire policy into output.json
`opa eval data.main --format pretty -i input.json -b . > output.json`

### Evaluate findings only
`opa eval data.main.findings --format pretty -i input.json -b . > output.json`
