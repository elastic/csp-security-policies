# Rules Status

## K8S CIS Benchmark

### 92/125 implemented rules  

|     |   Section # | Recommendation #   | Title                                                                                                    | Implemented        |
|----:|------------:|:-------------------|:---------------------------------------------------------------------------------------------------------|:-------------------|
|   0 |         1.1 | 1.1.1              | Ensure that the API server pod specification file permissions are set to 644 or more restrictive         | :white_check_mark: |
|   1 |         1.1 | 1.1.2              | Ensure that the API server pod specification file ownership is set to root:root                          | :white_check_mark: |
|   2 |         1.1 | 1.1.3              | Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive | :white_check_mark: |
|   3 |         1.1 | 1.1.4              | Ensure that the controller manager pod specification file ownership is set to root:root                  | :white_check_mark: |
|   4 |         1.1 | 1.1.5              | Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive          | :white_check_mark: |
|   5 |         1.1 | 1.1.6              | Ensure that the scheduler pod specification file ownership is set to root:root                           | :white_check_mark: |
|   6 |         1.1 | 1.1.7              | Ensure that the etcd pod specification file permissions are set to 644 or more restrictive               | :white_check_mark: |
|   7 |         1.1 | 1.1.8              | Ensure that the etcd pod specification file ownership is set to root:root                                | :white_check_mark: |
|   8 |         1.1 | 1.1.9              | Ensure that the Container Network Interface file permissions are set to 644 or more restrictive          | :x:                |
|   9 |         1.1 | 1.1.10             | Ensure that the Container Network Interface file ownership is set to root:root                           | :x:                |
|  10 |         1.1 | 1.1.11             | Ensure that the etcd data directory permissions are set to 700 or more restrictive                       | :white_check_mark: |
|  11 |         1.1 | 1.1.12             | Ensure that the etcd data directory ownership is set to etcd:etcd                                        | :white_check_mark: |
|  12 |         1.1 | 1.1.13             | Ensure that the admin.conf file permissions are set to 600                                               | :white_check_mark: |
|  13 |         1.1 | 1.1.14             | Ensure that the admin.conf file ownership is set to root:root                                            | :white_check_mark: |
|  14 |         1.1 | 1.1.15             | Ensure that the scheduler.conf file permissions are set to 644 or more restrictive                       | :white_check_mark: |
|  15 |         1.1 | 1.1.16             | Ensure that the scheduler.conf file ownership is set to root:root                                        | :white_check_mark: |
|  16 |         1.1 | 1.1.17             | Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive              | :white_check_mark: |
|  17 |         1.1 | 1.1.18             | Ensure that the controller-manager.conf file ownership is set to root:root                               | :white_check_mark: |
|  18 |         1.1 | 1.1.19             | Ensure that the Kubernetes PKI directory and file ownership is set to root:root                          | :white_check_mark: |
|  19 |         1.1 | 1.1.20             | Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive           | :white_check_mark: |
|  20 |         1.1 | 1.1.21             | Ensure that the Kubernetes PKI key file permissions are set to 600                                       | :white_check_mark: |
|  21 |         1.2 | 1.2.1              | Ensure that the --anonymous-auth argument is set to false                                                | :x:                |
|  22 |         1.2 | 1.2.2              | Ensure that the --token-auth-file parameter is not set                                                   | :white_check_mark: |
|  23 |         1.2 | 1.2.3              | Ensure that the --DenyServiceExternalIPs is not set                                                      | :x:                |
|  24 |         1.2 | 1.2.4              | Ensure that the --kubelet-https argument is set to true                                                  | :white_check_mark: |
|  25 |         1.2 | 1.2.5              | Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate   | :white_check_mark: |
|  26 |         1.2 | 1.2.6              | Ensure that the --kubelet-certificate-authority argument is set as appropriate                           | :white_check_mark: |
|  27 |         1.2 | 1.2.7              | Ensure that the --authorization-mode argument is not set to AlwaysAllow                                  | :white_check_mark: |
|  28 |         1.2 | 1.2.8              | Ensure that the --authorization-mode argument includes Node                                              | :white_check_mark: |
|  29 |         1.2 | 1.2.9              | Ensure that the --authorization-mode argument includes RBAC                                              | :white_check_mark: |
|  30 |         1.2 | 1.2.10             | Ensure that the admission control plugin EventRateLimit is set                                           | :white_check_mark: |
|  31 |         1.2 | 1.2.11             | Ensure that the admission control plugin AlwaysAdmit is not set                                          | :white_check_mark: |
|  32 |         1.2 | 1.2.12             | Ensure that the admission control plugin AlwaysPullImages is set                                         | :white_check_mark: |
|  33 |         1.2 | 1.2.13             | Ensure that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used     | :white_check_mark: |
|  34 |         1.2 | 1.2.14             | Ensure that the admission control plugin ServiceAccount is set                                           | :white_check_mark: |
|  35 |         1.2 | 1.2.15             | Ensure that the admission control plugin NamespaceLifecycle is set                                       | :white_check_mark: |
|  36 |         1.2 | 1.2.16             | Ensure that the admission control plugin NodeRestriction is set                                          | :white_check_mark: |
|  37 |         1.2 | 1.2.17             | Ensure that the --secure-port argument is not set to 0                                                   | :white_check_mark: |
|  38 |         1.2 | 1.2.18             | Ensure that the --profiling argument is set to false                                                     | :white_check_mark: |
|  39 |         1.2 | 1.2.19             | Ensure that the --audit-log-path argument is set                                                         | :white_check_mark: |
|  40 |         1.2 | 1.2.20             | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate                               | :white_check_mark: |
|  41 |         1.2 | 1.2.21             | Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate                            | :white_check_mark: |
|  42 |         1.2 | 1.2.22             | Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate                             | :white_check_mark: |
|  43 |         1.2 | 1.2.23             | Ensure that the --request-timeout argument is set as appropriate                                         | :white_check_mark: |
|  44 |         1.2 | 1.2.24             | Ensure that the --service-account-lookup argument is set to true                                         | :white_check_mark: |
|  45 |         1.2 | 1.2.25             | Ensure that the --service-account-key-file argument is set as appropriate                                | :white_check_mark: |
|  46 |         1.2 | 1.2.26             | Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate                      | :white_check_mark: |
|  47 |         1.2 | 1.2.27             | Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate              | :white_check_mark: |
|  48 |         1.2 | 1.2.28             | Ensure that the --client-ca-file argument is set as appropriate                                          | :white_check_mark: |
|  49 |         1.2 | 1.2.29             | Ensure that the --etcd-cafile argument is set as appropriate                                             | :white_check_mark: |
|  50 |         1.2 | 1.2.30             | Ensure that the --encryption-provider-config argument is set as appropriate                              | :x:                |
|  51 |         1.2 | 1.2.31             | Ensure that encryption providers are appropriately configured                                            | :x:                |
|  52 |         1.2 | 1.2.32             | Ensure that the API Server only makes use of Strong Cryptographic Ciphers                                | :white_check_mark: |
|  53 |         1.3 | 1.3.1              | Ensure that the --terminated-pod-gc-threshold argument is set as appropriate                             | :x:                |
|  54 |         1.3 | 1.3.2              | Ensure that the --profiling argument is set to false                                                     | :white_check_mark: |
|  55 |         1.3 | 1.3.3              | Ensure that the --use-service-account-credentials argument is set to true                                | :white_check_mark: |
|  56 |         1.3 | 1.3.4              | Ensure that the --service-account-private-key-file  argument is set as appropriate                       | :white_check_mark: |
|  57 |         1.3 | 1.3.5              | Ensure that the --root-ca-file argument is set as appropriate                                            | :white_check_mark: |
|  58 |         1.3 | 1.3.7              | Ensure that the --bind-address argument is set to 127.0.0.1                                              | :white_check_mark: |
|  59 |         1.4 | 1.4.1              | Ensure that the --profiling argument is set to false                                                     | :white_check_mark: |
|  60 |         1.4 | 1.4.2              | Ensure that the --bind-address argument is set to 127.0.0.1                                              | :white_check_mark: |
|  61 |         2   | 2.1                | Ensure that the --cert-file and --key-file arguments are set as appropriate                              | :white_check_mark: |
|  62 |         2   | 2.2                | Ensure that the --client-cert-auth argument is set to true                                               | :white_check_mark: |
|  63 |         2   | 2.3                | Ensure that the --auto-tls argument is not set to true                                                   | :white_check_mark: |
|  64 |         2   | 2.4                | Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate                    | :white_check_mark: |
|  65 |         2   | 2.5                | Ensure that the --peer-client-cert-auth argument is set to true                                          | :white_check_mark: |
|  66 |         2   | 2.6                | Ensure that the --peer-auto-tls argument is not set to true                                              | :white_check_mark: |
|  67 |         3.1 | 3.1.1              | Client certificate authentication should not be used for users                                           | :x:                |
|  68 |         3.2 | 3.2.1              | Ensure that a minimal audit policy is created                                                            | :x:                |
|  69 |         5.1 | 5.1.1              | Ensure that the cluster-admin role is only used where required                                           | :x:                |
|  70 |         5.1 | 5.1.2              | Minimize access to secrets                                                                               | :x:                |
|  71 |         5.1 | 5.1.4              | Minimize access to create pods                                                                           | :x:                |
|  72 |         5.1 | 5.1.5              | Ensure that default service accounts are not actively used.                                              | :white_check_mark: |
|  73 |         5.1 | 5.1.6              | Ensure that Service Account Tokens are only mounted where necessary                                      | :white_check_mark: |
|  74 |         5.1 | 5.1.7              | Avoid use of system:masters group                                                                        | :x:                |
|  75 |         5.1 | 5.1.8              | Limit use of the Bind, Impersonate and Escalate permissions in the Kubernetes cluster                    | :x:                |
|  76 |         5.2 | 5.2.1              | Ensure that the cluster has at least one active policy control mechanism in place                        | :x:                |
|  77 |         5.2 | 5.2.2              | Minimize the admission of privileged containers                                                          | :white_check_mark: |
|  78 |         5.2 | 5.2.3              | Minimize the admission of containers wishing to share the host process ID namespace                      | :white_check_mark: |
|  79 |         5.2 | 5.2.4              | Minimize the admission of containers wishing to share the host IPC namespace                             | :white_check_mark: |
|  80 |         5.2 | 5.2.5              | Minimize the admission of containers wishing to share the host network namespace                         | :white_check_mark: |
|  81 |         5.2 | 5.2.6              | Minimize the admission of containers with allowPrivilegeEscalation                                       | :white_check_mark: |
|  82 |         5.2 | 5.2.8              | Minimize the admission of containers with the NET_RAW capability                                         | :white_check_mark: |
|  83 |         5.2 | 5.2.9              | Minimize the admission of containers with added capabilities                                             | :white_check_mark: |
|  84 |         5.2 | 5.2.11             | Minimize the admission of Windows HostProcess Containers                                                 | :x:                |
|  85 |         5.2 | 5.2.12             | Minimize the admission of HostPath volumes                                                               | :x:                |
|  86 |         5.2 | 5.2.13             | Minimize the admission of containers which use HostPorts                                                 | :x:                |
|  87 |         5.3 | 5.3.1              | Ensure that the CNI in use supports Network Policies                                                     | :x:                |
|  88 |         5.7 | 5.7.1              | Create administrative boundaries between resources using namespaces                                      | :x:                |
|  89 |         1.3 | 1.3.6              | Ensure that the RotateKubeletServerCertificate argument is set to true                                   | :white_check_mark: |
|  90 |         2   | 2.7                | Ensure that a unique Certificate Authority is used for etcd                                              | :x:                |
|  91 |         3.2 | 3.2.2              | Ensure that the audit policy covers key security concerns                                                | :x:                |
|  92 |         5.2 | 5.2.7              | Minimize the admission of root containers                                                                | :white_check_mark: |
|  93 |         5.2 | 5.2.10             | Minimize the admission of containers with capabilities assigned                                          | :white_check_mark: |
|  94 |         5.3 | 5.3.2              | Ensure that all Namespaces have Network Policies defined                                                 | :x:                |
|  95 |         5.4 | 5.4.1              | Prefer using secrets as files over secrets as environment variables                                      | :x:                |
|  96 |         5.4 | 5.4.2              | Consider external secret storage                                                                         | :x:                |
|  97 |         5.5 | 5.5.1              | Configure Image Provenance using ImagePolicyWebhook admission controller                                 | :x:                |
|  98 |         5.7 | 5.7.2              | Ensure that the seccomp profile is set to docker/default in your pod definitions                         | :x:                |
|  99 |         5.7 | 5.7.3              | Apply Security Context to Your Pods and Containers                                                       | :x:                |
| 100 |         5.7 | 5.7.4              | The default namespace should not be used                                                                 | :x:                |
| 101 |         4.1 | 4.1.1              | Ensure that the kubelet service file permissions are set to 644 or more restrictive                      | :white_check_mark: |
| 102 |         4.1 | 4.1.2              | Ensure that the kubelet service file ownership is set to root:root                                       | :white_check_mark: |
| 103 |         4.1 | 4.1.3              | If proxy kubeconfig file exists ensure permissions are set to 644 or more restrictive                    | :x:                |
| 104 |         4.1 | 4.1.4              | If proxy kubeconfig file exists ensure ownership is set to root:root                                     | :x:                |
| 105 |         4.1 | 4.1.5              | Ensure that the --kubeconfig kubelet.conf file permissions are set to 644 or more restrictive            | :white_check_mark: |
| 106 |         4.1 | 4.1.6              | Ensure that the --kubeconfig kubelet.conf file ownership is set to root:root                             | :white_check_mark: |
| 107 |         4.1 | 4.1.7              | Ensure that the certificate authorities file permissions are set to 644 or more restrictive              | :x:                |
| 108 |         4.1 | 4.1.8              | Ensure that the client certificate authorities file ownership is set to root:root                        | :x:                |
| 109 |         4.1 | 4.1.9              | Ensure that the kubelet --config configuration file has permissions set to 644 or more restrictive       | :white_check_mark: |
| 110 |         4.1 | 4.1.10             | Ensure that the kubelet --config configuration file ownership is set to root:root                        | :white_check_mark: |
| 111 |         4.2 | 4.2.1              | Ensure that the --anonymous-auth argument is set to false                                                | :white_check_mark: |
| 112 |         4.2 | 4.2.2              | Ensure that the --authorization-mode argument is not set to AlwaysAllow                                  | :white_check_mark: |
| 113 |         4.2 | 4.2.3              | Ensure that the --client-ca-file argument is set as appropriate                                          | :white_check_mark: |
| 114 |         4.2 | 4.2.4              | Verify that the --read-only-port argument is set to 0                                                    | :white_check_mark: |
| 115 |         4.2 | 4.2.5              | Ensure that the --streaming-connection-idle-timeout argument is not set to 0                             | :white_check_mark: |
| 116 |         4.2 | 4.2.6              | Ensure that the --protect-kernel-defaults argument is set to true                                        | :white_check_mark: |
| 117 |         4.2 | 4.2.7              | Ensure that the --make-iptables-util-chains argument is set to true                                      | :white_check_mark: |
| 118 |         4.2 | 4.2.8              | Ensure that the --hostname-override argument is not set                                                  | :white_check_mark: |
| 119 |         4.2 | 4.2.10             | Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate              | :white_check_mark: |
| 120 |         4.2 | 4.2.11             | Ensure that the --rotate-certificates argument is not set to false                                       | :white_check_mark: |
| 121 |         4.2 | 4.2.12             | Verify that the RotateKubeletServerCertificate argument is set to true                                   | :white_check_mark: |
| 122 |         4.2 | 4.2.13             | Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers                                   | :white_check_mark: |
| 123 |         5.1 | 5.1.3              | Minimize wildcard use in Roles and ClusterRoles                                                          | :white_check_mark: |
| 124 |         4.2 | 4.2.9              | Ensure that the --event-qps argument is set to 0 or a level which ensures appropriate event capture      | :white_check_mark: |## EKS CIS Benchmark

### 31/53 implemented rules  

|    |   Section # | Recommendation #   | Title of Recommendation                                                                                  | Implemented        |
|---:|------------:|:-------------------|:---------------------------------------------------------------------------------------------------------|:-------------------|
|  0 |         1   |                    | Master (Control Plane) Components                                                                        | :x:                |
|  1 |         2.1 | 2.1.1              | Enable audit Logs                                                                                        | :white_check_mark: |
|  2 |         3.1 | 3.1.1              | Ensure that the kubeconfig file permissions are set to 644 or more restrictive                           | :white_check_mark: |
|  3 |         3.1 | 3.1.2              | Ensure that the kubelet kubeconfig file ownership is set to root:root                                    | :white_check_mark: |
|  4 |         3.1 | 3.1.3              | Ensure that the kubelet configuration file has permissions set to 644 or more restrictive                | :white_check_mark: |
|  5 |         3.1 | 3.1.4              | Ensure that the kubelet configuration file ownership is set to root:root                                 | :white_check_mark: |
|  6 |         3.2 | 3.2.1              | Ensure that the --anonymous-auth argument is set to false                                                | :white_check_mark: |
|  7 |         3.2 | 3.2.2              | Ensure that the --authorization-mode argument is not set to AlwaysAllow                                  | :white_check_mark: |
|  8 |         3.2 | 3.2.3              | Ensure that the --client-ca-file argument is set as appropriate                                          | :white_check_mark: |
|  9 |         3.2 | 3.2.4              | Ensure that the --read-only-port is secured                                                              | :white_check_mark: |
| 10 |         3.2 | 3.2.5              | Ensure that the --streaming-connection-idle-timeout argument is not set to 0                             | :white_check_mark: |
| 11 |         3.2 | 3.2.6              | Ensure that the --protect-kernel-defaults argument is set to true                                        | :white_check_mark: |
| 12 |         3.2 | 3.2.7              | Ensure that the --make-iptables-util-chains argument is set to true                                      | :white_check_mark: |
| 13 |         3.2 | 3.2.8              | Ensure that the --hostname-override argument is not set                                                  | :white_check_mark: |
| 14 |         3.2 | 3.2.9              | Ensure that the --eventRecordQPS argument is set to 0 or a level which ensures appropriate event capture | :white_check_mark: |
| 15 |         3.2 | 3.2.10             | Ensure that the --rotate-certificates argument is not set to false                                       | :white_check_mark: |
| 16 |         3.2 | 3.2.11             | Ensure that the RotateKubeletServerCertificate argument is set to true                                   | :white_check_mark: |
| 17 |         3.3 | 3.3.1              | Prefer using Container-Optimized OS when possible                                                        | :x:                |
| 18 |         4.1 | 4.1.1              | Ensure that the cluster-admin role is only used where required                                           | :x:                |
| 19 |         4.1 | 4.1.2              | Minimize access to secrets                                                                               | :x:                |
| 20 |         4.1 | 4.1.3              | Minimize wildcard use in Roles and ClusterRoles                                                          | :x:                |
| 21 |         4.1 | 4.1.4              | Minimize access to create pods                                                                           | :x:                |
| 22 |         4.1 | 4.1.5              | Ensure that default service accounts are not actively used.                                              | :x:                |
| 23 |         4.1 | 4.1.6              | Ensure that Service Account Tokens are only mounted where necessary                                      | :x:                |
| 24 |         4.2 | 4.2.1              | Minimize the admission of privileged containers                                                          | :white_check_mark: |
| 25 |         4.2 | 4.2.2              | Minimize the admission of containers wishing to share the host process ID namespace                      | :white_check_mark: |
| 26 |         4.2 | 4.2.3              | Minimize the admission of containers wishing to share the host IPC namespace                             | :white_check_mark: |
| 27 |         4.2 | 4.2.4              | Minimize the admission of containers wishing to share the host network namespace                         | :white_check_mark: |
| 28 |         4.2 | 4.2.5              | Minimize the admission of containers with allowPrivilegeEscalation                                       | :white_check_mark: |
| 29 |         4.2 | 4.2.6              | Minimize the admission of root containers                                                                | :white_check_mark: |
| 30 |         4.2 | 4.2.7              | Minimize the admission of containers with the NET_RAW capability                                         | :white_check_mark: |
| 31 |         4.2 | 4.2.8              | Minimize the admission of containers with added capabilities                                             | :white_check_mark: |
| 32 |         4.2 | 4.2.9              | Minimize the admission of containers with capabilities assigned                                          | :white_check_mark: |
| 33 |         4.4 | 4.3.1              | Ensure latest CNI version is used                                                                        | :x:                |
| 34 |         4.4 | 4.3.2              | Ensure that all Namespaces have Network Policies defined                                                 | :x:                |
| 35 |         4.5 | 4.4.1              | Prefer using secrets as files over secrets as environment variables                                      | :x:                |
| 36 |         4.5 | 4.4.2              | Consider external secret storage                                                                         | :x:                |
| 37 |         4.7 | 4.6.1              | Create administrative boundaries between resources using namespaces                                      | :x:                |
| 38 |         4.7 | 4.6.2              | Apply Security Context to Your Pods and Containers                                                       | :x:                |
| 39 |         4.7 | 4.6.3              | The default namespace should not be used                                                                 | :x:                |
| 40 |         5.1 | 5.1.1              | Ensure Image Vulnerability Scanning using Azure Defender image scanning or a third party provider        | :white_check_mark: |
| 41 |         5.1 | 5.1.2              | Minimize user access to Azure Container Registry (ACR)                                                   | :x:                |
| 42 |         5.1 | 5.1.3              | Minimize cluster access to read-only for Azure Container Registry (ACR)                                  | :x:                |
| 43 |         5.1 | 5.1.4              | Minimize Container Registries to only those approved                                                     | :x:                |
| 44 |         5.2 | 5.2.1              | Prefer using dedicated AKS Service Accounts                                                              | :x:                |
| 45 |         5.3 | 5.3.1              | Ensure Kubernetes Secrets are encrypted                                                                  | :white_check_mark: |
| 46 |         5.4 | 5.4.1              | Restrict Access to the Control Plane Endpoint                                                            | :white_check_mark: |
| 47 |         5.4 | 5.4.2              | Ensure clusters are created with Private Endpoint Enabled and Public Access Disabled                     | :white_check_mark: |
| 48 |         5.4 | 5.4.3              | Ensure clusters are created with Private Nodes                                                           | :white_check_mark: |
| 49 |         5.4 | 5.4.4              | Ensure Network Policy is Enabled and set as appropriate                                                  | :x:                |
| 50 |         5.4 | 5.4.5              | Encrypt traffic to HTTPS load balancers with TLS certificates                                            | :white_check_mark: |
| 51 |         5.5 | 5.5.1              | Manage Kubernetes RBAC users with Azure AD                                                               | :x:                |
| 52 |         5.6 | 5.6.1              | Consider Fargate for running untrusted workloads                                                         | :x:                |## AWS CIS Benchmark

### 2/63 implemented rules  

|    |   Section # | Recommendation #   | Title of Recommendation                                                                                            | Implemented        |
|---:|------------:|:-------------------|:-------------------------------------------------------------------------------------------------------------------|:-------------------|
|  0 |         1   | 1.1                | Maintain current contact details                                                                                   | :x:                |
|  1 |         1   | 1.2                | Ensure security contact information is registered                                                                  | :x:                |
|  2 |         1   | 1.3                | Ensure security questions are registered in the AWS account                                                        | :x:                |
|  3 |         1   | 1.4                | Ensure no 'root' user account access key exists                                                                    | :x:                |
|  4 |         1   | 1.5                | Ensure MFA is enabled for the 'root' user account                                                                  | :x:                |
|  5 |         1   | 1.6                | Ensure hardware MFA is enabled for the 'root' user account                                                         | :x:                |
|  6 |         1   | 1.7                | Eliminate use of the 'root' user for administrative and daily tasks                                                | :x:                |
|  7 |         1   | 1.8                | Ensure IAM password policy requires minimum length of 14 or greater                                                | :white_check_mark: |
|  8 |         1   | 1.9                | Ensure IAM password policy prevents password reuse                                                                 | :white_check_mark: |
|  9 |         1   | 1.10               | Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password                 | :x:                |
| 10 |         1   | 1.11               | Do not setup access keys during initial user setup for all IAM users that have a console password                  | :x:                |
| 11 |         1   | 1.12               | Ensure credentials unused for 45 days or greater are disabled                                                      | :x:                |
| 12 |         1   | 1.13               | Ensure there is only one active access key available for any single IAM user                                       | :x:                |
| 13 |         1   | 1.14               | Ensure access keys are rotated every 90 days or less                                                               | :x:                |
| 14 |         1   | 1.15               | Ensure IAM Users Receive Permissions Only Through Groups                                                           | :x:                |
| 15 |         1   | 1.16               | Ensure IAM policies that allow full "*:*" administrative privileges are not attached                               | :x:                |
| 16 |         1   | 1.17               | Ensure a support role has been created to manage incidents with AWS Support                                        | :x:                |
| 17 |         1   | 1.18               | Ensure IAM instance roles are used for AWS resource access from instances                                          | :x:                |
| 18 |         1   | 1.19               | Ensure that all the expired SSL/TLS certificates stored in AWS IAM are removed                                     | :x:                |
| 19 |         1   | 1.20               | Ensure that IAM Access analyzer is enabled for all regions                                                         | :x:                |
| 20 |         1   | 1.21               | Ensure IAM users are managed centrally via identity federation or AWS Organizations for multi-account environments | :x:                |
| 21 |         2.1 | 2.1.1              | Ensure all S3 buckets employ encryption-at-rest                                                                    | :x:                |
| 22 |         2.1 | 2.1.2              | Ensure S3 Bucket Policy is set to deny HTTP requests                                                               | :x:                |
| 23 |         2.1 | 2.1.3              | Ensure MFA Delete is enable on S3 buckets                                                                          | :x:                |
| 24 |         2.1 | 2.1.4              | Ensure all data in Amazon S3 has been discovered, classified and secured when required.                            | :x:                |
| 25 |         2.1 | 2.1.5              | Ensure that S3 Buckets are configured with 'Block public access (bucket settings)'                                 | :x:                |
| 26 |         2.2 | 2.2.1              | Ensure EBS Volume Encryption is Enabled in all Regions                                                             | :x:                |
| 27 |         2.3 | 2.3.1              | Ensure that encryption is enabled for RDS Instances                                                                | :x:                |
| 28 |         2.3 | 2.3.2              | Ensure Auto Minor Version Upgrade feature is Enabled for RDS Instances                                             | :x:                |
| 29 |         2.3 | 2.3.3              | Ensure that public access is not given to RDS Instance                                                             | :x:                |
| 30 |         2.4 | 2.4.1              | Ensure that encryption is enabled for EFS file systems                                                             | :x:                |
| 31 |         3   | 3.1                | Ensure CloudTrail is enabled in all regions                                                                        | :x:                |
| 32 |         3   | 3.2                | Ensure CloudTrail log file validation is enabled                                                                   | :x:                |
| 33 |         3   | 3.3                | Ensure the S3 bucket used to store CloudTrail logs is not publicly accessible                                      | :x:                |
| 34 |         3   | 3.4                | Ensure CloudTrail trails are integrated with CloudWatch Logs                                                       | :x:                |
| 35 |         3   | 3.5                | Ensure AWS Config is enabled in all regions                                                                        | :x:                |
| 36 |         3   | 3.6                | Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket                                             | :x:                |
| 37 |         3   | 3.7                | Ensure CloudTrail logs are encrypted at rest using KMS CMKs                                                        | :x:                |
| 38 |         3   | 3.8                | Ensure rotation for customer created CMKs is enabled                                                               | :x:                |
| 39 |         3   | 3.9                | Ensure VPC flow logging is enabled in all VPCs                                                                     | :x:                |
| 40 |         3   | 3.10               | Ensure that Object-level logging for write events is enabled for S3 bucket                                         | :x:                |
| 41 |         3   | 3.11               | Ensure that Object-level logging for read events is enabled for S3 bucket                                          | :x:                |
| 42 |         4   | 4.1                | Ensure a log metric filter and alarm exist for unauthorized API calls                                              | :x:                |
| 43 |         4   | 4.2                | Ensure a log metric filter and alarm exist for Management Console sign-in without MFA                              | :x:                |
| 44 |         4   | 4.3                | Ensure a log metric filter and alarm exist for usage of 'root' account                                             | :x:                |
| 45 |         4   | 4.4                | Ensure a log metric filter and alarm exist for IAM policy changes                                                  | :x:                |
| 46 |         4   | 4.5                | Ensure a log metric filter and alarm exist for CloudTrail configuration changes                                    | :x:                |
| 47 |         4   | 4.6                | Ensure a log metric filter and alarm exist for AWS Management Console authentication failures                      | :x:                |
| 48 |         4   | 4.7                | Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer created CMKs            | :x:                |
| 49 |         4   | 4.8                | Ensure a log metric filter and alarm exist for S3 bucket policy changes                                            | :x:                |
| 50 |         4   | 4.9                | Ensure a log metric filter and alarm exist for AWS Config configuration changes                                    | :x:                |
| 51 |         4   | 4.10               | Ensure a log metric filter and alarm exist for security group changes                                              | :x:                |
| 52 |         4   | 4.11               | Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL)                      | :x:                |
| 53 |         4   | 4.12               | Ensure a log metric filter and alarm exist for changes to network gateways                                         | :x:                |
| 54 |         4   | 4.13               | Ensure a log metric filter and alarm exist for route table changes                                                 | :x:                |
| 55 |         4   | 4.14               | Ensure a log metric filter and alarm exist for VPC changes                                                         | :x:                |
| 56 |         4   | 4.15               | Ensure a log metric filter and alarm exists for AWS Organizations changes                                          | :x:                |
| 57 |         4   | 4.16               | Ensure AWS Security Hub is enabled                                                                                 | :x:                |
| 58 |         5   | 5.1                | Ensure no Network ACLs allow ingress from 0.0.0.0/0 to remote server administration ports                          | :x:                |
| 59 |         5   | 5.2                | Ensure no security groups allow ingress from 0.0.0.0/0 to remote server administration ports                       | :x:                |
| 60 |         5   | 5.3                | Ensure no security groups allow ingress from ::/0 to remote server administration ports                            | :x:                |
| 61 |         5   | 5.4                | Ensure the default security group of every VPC restricts all traffic                                               | nan                |
| 62 |         5   | 5.5                | Ensure routing tables for VPC peering are "least access"                                                           | nan                |
