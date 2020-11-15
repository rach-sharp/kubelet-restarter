### Workaround for `kubelet` reporting `use of closed network connection`

https://github.com/kubernetes/kubernetes/issues/87615 details a bug which causes Kubernetes Nodes to enter `NotReady` and get stuck permanently.

Symptoms:

- Kubernetes master or worker node is in NotReady state for a long period of time
- "use of closed network connection" appears in Kubelet logs after it gets stuck in NotReady (identify with `journalctl -u kubelet.service | grep "use of closed network connection"`)
- Node becomes ready again after Kubelet is restarted (`service restart kubelet`)

Fix:

- Possibly an actual fix is on the way, the linked thread mentions bug reports in `http.go` etc.
- This bodge restarts the kubelet when it sees the symptomatic error log (adapted from https://github.com/kubernetes/kubernetes/issues/87615#issuecomment-609413225). You need SSH access and Hostnames / IP Addresses for all your Kubernetes Nodes.


How to use:

- [Install Ansible Playbooks](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Configure your `inventory.yaml` (use `example.yaml` as a reference)
- `run_playbook.sh`


How it works:

- Have a script that scrapes the last 60 secs of logs and looks for the error message
- Run the script as a `systemd` unit on a timer every 60 seconds