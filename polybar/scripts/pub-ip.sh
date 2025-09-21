sleep 1
ip route get 1 | awk '{print $7}'
