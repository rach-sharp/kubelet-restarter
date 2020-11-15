#!/bin/bash
output=$(journalctl -u kubelet --since=-59s | grep "use of closed network connection")
if [[ $? != 0 ]]; then
  echo "Error not found in logs"
elif [[ $output ]]; then
  echo "Restart kubelet"
  systemctl restart kubelet
fi