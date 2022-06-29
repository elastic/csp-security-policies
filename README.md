# cis_policies_generator
Running `npm start` will create a JSON file for every XLSX benchmark in the `input` folder

Example serialization of a single rule:

```
{
    "id": "883ab83b-8dbc-5072-aef7-0f4c4a7f4048",
    "name": "Ensure that the API server pod specification file permissions are set to 644 or more restrictive",
    "rule_number": "1.1.1",
    "profile_applicability": "* Level 1 - Master Node",
    "description": "Ensure that the API server pod specification file has permissions of `644` or more restrictive.",
    "rationale": "The API server pod specification file controls various parameters that set the behavior of the API server. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.",
    "audit": "Run the below command (based on the file location on your system) on the Control Plane node. For example,\n\n```\nstat -c %a /etc/kubernetes/manifests/kube-apiserver.yaml\n```\n\nVerify that the permissions are `644` or more restrictive.",
    "remediation": "Run the below command (based on the file location on your system) on the Control Plane node. For example,\n\n```\nchmod 644 /etc/kubernetes/manifests/kube-apiserver.yaml\n```",
    "impact": "None",
    "references": [
        "https://kubernetes.io/docs/admin/kube-apiserver/"
    ],
    "section": "Control Plane Node Configuration Files",
    "benchmark": {
        "name": "CIS Kubernetes V1.23",
        "version": "v1.0.1"
    }
}
```
