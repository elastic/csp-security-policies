# cis_policies_generator
Running `npm start` will create a JSON file for every XLSX benchmark in the `input` folder

Example serialization of a single rule:

```
  {
    "id": "eb372e09-7ff2-54a0-a875-36f025f0b425",
    "rule_number": "1.1.11",
    "profile_applicability": "* Level 1 - Master Node",
    "description": "Ensure that the etcd data directory has permissions of `700` or more restrictive.",
    "audit": "On the etcd server node, get the etcd data directory, passed as an argument `--data-dir`, from the below command:\r\n\r\n```\r\nps -ef | grep etcd\r\n```\r\n\r\nRun the below command (based on the etcd data directory found above). For example,\r\n\r\n```\r\nstat -c %a /var/lib/etcd\r\n```\r\n\r\nVerify that the permissions are `700` or more restrictive.",
    "remediation": "On the etcd server node, get the etcd data directory, passed as an argument `--data-dir`, from the below command:\r\n```\r\nps -ef | grep etcd\r\n```\r\nRun the below command (based on the etcd data directory found above). For example,\r\n```\r\nchmod 700 /var/lib/etcd\r\n```",
    "impact": "None",
    "references": [
      "https://coreos.com/etcd/docs/latest/op-guide/configuration.html#data-dir",
      "https://kubernetes.io/docs/admin/etcd/"
    ],
    "section": "Master Node Configuration Files",
    "benchmark": {
      "name": "CIS Kubernetes V1.20",
      "version": "v1.0.1"
    }
  }
```
