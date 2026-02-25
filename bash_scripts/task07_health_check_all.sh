#!/bin/bash
healthy=0; total=0
while IFS= read -r server; do
  ((total++))
  if [ -f /tmp/configs/${server}.state ]; then
    echo "${server}: HEALTHY"
    ((healthy++))
  else
    echo "${server}: UNHEALTHY"
  fi
done < /tmp/servers.txt
echo "Summary: ${healthy}/${total} healthy"
