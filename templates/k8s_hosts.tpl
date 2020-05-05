all:
  hosts:
    node1:
      ip: 10.0.1.1
      access_ip: 95.216.214.76
      ansible_host: 95.216.214.76
    node2:
      ip: 10.0.1.2
      access_ip: 95.216.215.95
      ansible_host: 95.216.215.95
    node3:
      ip: 10.0.1.3
      access_ip: 95.216.150.59
      ansible_host: 95.216.150.59
  children:
    kube-master:
      hosts:
        node1:
        node2:
    kube-node:
      hosts:
        node1:
        node2:
        node3:
    etcd:
      hosts:
        node1:
        node2:
        node3:
    k8s-cluster:
      children:
        kube-master:
        kube-node:
    calico-rr:
      hosts: {}
