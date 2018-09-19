<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-its%20go%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-matthew@matthewdavis.io-blue.svg?style=flat-square)](skype:matthew@matthewdavis.io?chat)

# VerneMQ (MQTT) @ Kubernetes

> k8 by example -- straight to the point, simple execution.

VerneMQ is a high-performance, distributed MQTT broker. It scales horizontally and vertically on commodity hardware to support a high number of concurrent publishers and consumers while maintaining low latency and fault tolerance. https://vernemq.com

# Preparation

Clone this repo:

```sh
$ git clone https://github.com/mateothegreat/k8-byexamples-vernemq
$ cd k8-byexamples-vernemq
$ git submodule update --init
```

Generate SSL Certificates, local user & load them in k8 as secrets:

```sh
$ make setup
```

# Install
```sh
$ make install

[ INSTALLING MANIFESTS/SERVICE-EXTERNAL-MQTTS.YAML ]:
service/mqtts created
[ INSTALLING MANIFESTS/RBAC-ROLEBINDING.YAML ]:
rolebinding.rbac.authorization.k8s.io/endpoint-reader created
[ INSTALLING MANIFESTS/RBAC-ROLE.YAML ]:
role.rbac.authorization.k8s.io/endpoint-reader created
[ INSTALLING MANIFESTS/SERVICE-INTERNAL.YAML ]:
service/vernemq created
[ INSTALLING MANIFESTS/SERVICE-EXTERNAL-MQTT.YAML ]:
service/mqtt created
[ INSTALLING MANIFESTS/RBAC-SERVICEACCOUNT.YAML ]:
serviceaccount/vernemq created
[ INSTALLING MANIFESTS/STATEFULSET.YAML ]:
statefulset.apps/vernemq created
```

# Testing
```sh
$ make test

kubectl exec vernemq-0 -- vmq-admin cluster show
+---------------------------------------------------+-------+
|                       Node                        |Running|
+---------------------------------------------------+-------+
|VerneMQ@vernemq-1.vernemq.default.svc.cluster.local| true  |
|VerneMQ@vernemq-2.vernemq.default.svc.cluster.local| true  |
|VerneMQ@vernemq-0.vernemq.default.svc.cluster.local| true  |
+---------------------------------------------------+-------+
```

# Cleanup

```sh
$ make delete

[ DELETING MANIFESTS/SERVICE-EXTERNAL-MQTTS.YAML ]:
service "mqtts" deleted
[ DELETING MANIFESTS/RBAC-ROLEBINDING.YAML ]:
rolebinding.rbac.authorization.k8s.io "endpoint-reader" deleted
[ DELETING MANIFESTS/RBAC-ROLE.YAML ]:
role.rbac.authorization.k8s.io "endpoint-reader" deleted
[ DELETING MANIFESTS/SERVICE-INTERNAL.YAML ]:
service "vernemq" deleted
[ DELETING MANIFESTS/SERVICE-EXTERNAL-MQTT.YAML ]:
service "mqtt" deleted
[ DELETING MANIFESTS/RBAC-SERVICEACCOUNT.YAML ]:
serviceaccount "vernemq" deleted
[ DELETING MANIFESTS/STATEFULSET.YAML ]:
statefulset.apps "vernemq" deleted
```

# See also

* Docker image: https://github.com/erlio/docker-vernemq
* Inspiration: https://github.com/nmatsui/kubernetes-vernemq