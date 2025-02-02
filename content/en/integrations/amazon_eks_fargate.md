---
categories:
- cloud
- aws
- log collection
description: Amazon EKS on AWS Fargate is a managed Kubernetes service that automates certain aspects of deployment and maintenance for any standard Kubernetes environment.
short_description: Amazon EKS on AWS Fargate is a managed Kubernetes service.
doc_link: https://docs.datadoghq.com/integrations/amazon_eks_fargate/
git_integration_title: amazon_eks_fargate
has_logo: true
integration_title: Amazon EKS on AWS Fargate
is_public: true
kind: integration
manifest_version: 1.0
name: amazon_eks_fargate
public_title: Datadog-Amazon EKS on AWS Fargate
version: 1.0
further_reading:
- link: "https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html"
  tag: "AWS Documentation"
  text: "Getting Started with AWS Fargate on Amazon EKS"
- link: "https://docs.aws.amazon.com/eks/latest/userguide/fargate.html"
  tag: "AWS Documentation"
  text: "AWS Fargate documentation"
- link: "https://www.datadoghq.com/blog/eks-fargate-monitoring/"
  tag: "Blog"
  text: "Monitor Amazon EKS on AWS Fargate with Datadog"
---

## Overview

Amazon EKS on AWS Fargate is a managed Kubernetes service that automates certain aspects of deployment and maintenance for any standard Kubernetes environment. Kubernetes nodes are managed by AWS Fargate and abstracted away from the user.

## Setup

These steps cover the setup of the Datadog Agent in a container within Amazon EKS on AWS Fargate. Refer to the [Datadog-Amazon EKS integration documentation][1] if you are not using AWS Fargate.

AWS Fargate pods are not physical pod, which means they exclude [host-based system-checks][2], like CPU, memory, etc. In order to collect data from your AWS Fargate pods, you must run the Agent as a sidecar of your application pod with custom RBAC, which enables these features:

* Kubernetes metrics collection from the pod running your application containers and the Agent
* [Autodiscovery][3]
* Configuration of custom Agent Checks to target containers in the same pod
* APM and DogStatsD for containers in the same pod

### EC2 Node

If you don't specify through [AWS Fargate Profile][4] that your pods should run on fargate, your pods can use classical EC2 machines. If it's the case refer to the [Datadog-Amazon EKS integration setup][5] in order to collect data from your them. This works by running the Agent as an EC2-type workload. The Agent setup is the same as that of the [Kuberenetes Agent setup][6], and all options are available. To deploy the Agent on EC2 nodes, use the [DaemonSet setup for the Datadog Agent][7].

### Installation

To get the best observability coverage monitoring workloads in AWS EKS Fargate, install the Datadog integrations for:

* [Kubernetes][8]
* [AWS][9]
* [EKS][10]
* [EC2][11] (if you are running an EC2-type node)

Also, set up integrations for any other AWS services you are running with EKS (for example, [ELB][12]).

#### Manual Installation

To install, download the custom Agent image: `datadog/agent:eks-fargate-beta`.

If the Agent is running as a sidecar, it can communicate only with containers on the same pod. Run an Agent for every pod you wish to monitor.

### Configuration

To collect data from your applications running in AWS EKS Fargate over a Fargate node, follow these setup steps:

* [Set up AWS EKS Fargate RBAC rules](#aws-eks-fargate-rbac).
* [Deploy the Agent as a sidecar](#running-the-agent-as-a-side-car).
* Set up Datadog [metrics](#metrics-collection), [events](#events-collection), and [traces](#traces-collection) collection.

#### AWS EKS Fargate RBAC

Use the following Agent RBAC when deploying the Agent as a sidecar in AWS EKS Fargate:


```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datadog-agent
rules:
  - apiGroups:
    - ""
    resources:
      - nodes/metrics
      - nodes/spec
      - nodes/stats
      - nodes/proxy
      - nodes/pods
      - nodes/healthz
    verbs:
      - get
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datadog-agent
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datadog-agent
subjects:
  - kind: ServiceAccount
    name: datadog-agent
    namespace: default
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: datadog-agent
  namespace: default
```

#### Running the Agent as a sidecar

To start collecting data from your Fargate type pod, deploy the Datadog Agent as a sidecar of your application. This is the minimum configuration required to collect metrics from your application running in the pod:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
 name: "<APPLICATION_NAME>"
 namespace: default
spec:
 replicas: 1
 template:
   metadata:
     labels:
       app: "<APPLICATION_NAME>"
     name: "<POD_NAME>"
​
   spec:
     serviceAccountName: datadog-agent
     containers:
     - name: "<APPLICATION_NAME>"
       image: "<APPLICATION_IMAGE>"
​
     ## Running the Agent as a side-car
     - image: datadog/agent:eks-fargate-beta
       name: datadog-agent
       env:
       - name: DD_API_KEY
         value: "<YOUR_DATADOG_API_KEY>"
         ## Set DD_SITE to "datadoghq.eu" to send your
         ## Agent data to the Datadog EU site
       - name: DD_SITE
         value: "datadoghq.com"
       - name: DD_EKS_FARGATE
         value: "true"
       - name: DD_KUBERNETES_KUBELET_NODENAME
         valueFrom:
           fieldRef:
             apiVersion: v1
             fieldPath: spec.nodeName
      resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```
​
**Note**: Don't forget to replace `<YOUR_DATADOG_API_KEY>` with the [Datadog API key from your organization][13].

## Metrics Collection

{{< tabs >}}
{{% tab "Integration metrics" %}}
​
Use [Autodiscovery labels with your application container][1] to start collecting its metrics for the [supported Agent integrations][2].

​
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
 name: "<APPLICATION_NAME>"
 namespace: default
spec:
 replicas: 1
 template:
   metadata:
     labels:
       app: "<APPLICATION_NAME>"
     name: "<POD_NAME>"
     annotations:
      ad.datadoghq.com/<CONTAINER_NAME>.check_names: '[<CHECK_NAME>]'
      ad.datadoghq.com/<CONTAINER_IDENTIFIER>.init_configs: '[<INIT_CONFIG>]'
      ad.datadoghq.com/<CONTAINER_IDENTIFIER>.instances: '[<INSTANCE_CONFIG>]'
​
   spec:
     serviceAccountName: datadog-agent
     containers:
     - name: "<APPLICATION_NAME>"
       image: "<APPLICATION_IMAGE>"
​
     ## Running the Agent as a side-car
     - image: datadog/agent:eks-fargate-beta
       name: datadog-agent
       env:
       - name: DD_API_KEY
         value: "<YOUR_DATADOG_API_KEY>"
         ## Set DD_SITE to "datadoghq.eu" to send your
         ## Agent data to the Datadog EU site
       - name: DD_SITE
         value: "datadoghq.com"
       - name: DD_EKS_FARGATE
         value: "true"
       - name: DD_KUBERNETES_KUBELET_NODENAME
         valueFrom:
           fieldRef:
             apiVersion: v1
             fieldPath: spec.nodeName
      resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```
​
**Note**: Don't forget to replace `<YOUR_DATADOG_API_KEY>` with the [Datadog API key from your organization][3].


[1]: /agent/autodiscovery/integrations
[2]: /integrations/#cat-autodiscovery
[3]: https://app.datadoghq.com/account/settings#api
{{% /tab %}}
{{% tab "DogStatsD" %}}

Set up the container port `8125` over your Agent container to forward [DogStatsD metrics][1] from your application container to Datadog.

​
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
 name: "<APPLICATION_NAME>"
 namespace: default
spec:
 replicas: 1
 template:
   metadata:
     labels:
       app: "<APPLICATION_NAME>"
     name: "<POD_NAME>"
​
   spec:
     serviceAccountName: datadog-agent
     containers:
     - name: "<APPLICATION_NAME>"
       image: "<APPLICATION_IMAGE>"
​
     ## Running the Agent as a side-car
     - image: datadog/agent:eks-fargate-beta
       name: datadog-agent
       ## Enabling port 8125 for DogStatsD metric collection
       ports:
        - containerPort: 8125
          name: dogstatsdport
          protocol: UDP
       env:
       - name: DD_API_KEY
         value: "<YOUR_DATADOG_API_KEY>"
         ## Set DD_SITE to "datadoghq.eu" to send your
         ## Agent data to the Datadog EU site
       - name: DD_SITE
         value: "datadoghq.com"
       - name: DD_EKS_FARGATE
         value: "true"
       - name: DD_KUBERNETES_KUBELET_NODENAME
         valueFrom:
           fieldRef:
             apiVersion: v1
             fieldPath: spec.nodeName
      resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```
​
**Note**: Don't forget to replace `<YOUR_DATADOG_API_KEY>` with the [Datadog API key from your organization][2].


[1]: /developers/dogstatsd
[2]: https://app.datadoghq.com/account/settings#api
{{% /tab %}}
{{< /tabs >}}

## Traces Collection

Set up the container port `8126` over your Agent container to collect traces from your application container. [Read more about how to set up tracing][14].

​
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
 name: "<APPLICATION_NAME>"
 namespace: default
spec:
 replicas: 1
 template:
   metadata:
     labels:
       app: "<APPLICATION_NAME>"
     name: "<POD_NAME>"
​
   spec:
     serviceAccountName: datadog-agent
     containers:
     - name: "<APPLICATION_NAME>"
       image: "<APPLICATION_IMAGE>"
​
     ## Running the Agent as a side-car
     - image: datadog/agent:eks-fargate-beta
       name: datadog-agent
       ## Enabling port 8126 for Trace collection
       ports:
        - containerPort: 8126
          name: traceport
          protocol: TCP
       env:
       - name: DD_API_KEY
         value: "<YOUR_DATADOG_API_KEY>"
         ## Set DD_SITE to "datadoghq.eu" to send your
         ## Agent data to the Datadog EU site
       - name: DD_SITE
         value: "datadoghq.com"
       - name: DD_EKS_FARGATE
         value: "true"
       - name: DD_APM_ENABLED
         value: "true"
       - name: DD_KUBERNETES_KUBELET_NODENAME
         valueFrom:
           fieldRef:
             apiVersion: v1
             fieldPath: spec.nodeName
      resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```
​
**Note**: Don't forget to replace `<YOUR_DATADOG_API_KEY>` with the [Datadog API key from your organization][13].

## Events Collection

To collect events from your AWS EKS Fargate API server, run a Datadog Cluster Agent over an AWS EKS EC2 pod within your Kubernetes cluster:

1. [Setup the Datadog Cluster Agent][15].
2. [Enable Event collection for your Cluster Agent][16].

Optionally, deploy cluster check runners in addition to setting up the Datadog Cluster Agent to enable cluster checks.

**Note**: You can also collect events if you run the Datadog Cluster Agent in a pod in Fargate.

## Troubleshooting

Need help? Contact [Datadog support][17].

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}

[1]: /integrations/amazon_eks/
[2]: /integrations/system
[3]: /agent/autodiscovery
[4]: https://docs.aws.amazon.com/eks/latest/userguide/fargate-profile.html
[5]: /integrations/amazon_eks/#setup
[6]: /agent/kubernetes
[7]: /agent/kubernetes/daemonset_setup
[8]: https://app.datadoghq.com/account/settings#integrations/kubernetes
[9]: https://app.datadoghq.com/account/settings#integrations/amazon-web-services
[10]: https://app.datadoghq.com/account/settings#integrations/amazon-eks
[11]: https://app.datadoghq.com/account/settings#integrations/amazon-ec2
[12]: /integrations/kubernetes
[13]: https://app.datadoghq.com/account/settings#api
[14]: /tracing/setup
[15]: /agent/cluster_agent/setup
[16]: /agent/cluster_agent/event_collection
[17]: https://docs.datadoghq.com/help
