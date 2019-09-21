#/bin/bash
set -e
#
# k8s-cms
# Proxy Service Entrypoint
#

# figure out the contest id that this proxy service targets.
CONTEST_ID=${CMS_CONTEST_ID:-"DEFAULT"}
POLL_INTERVAL=${CMS_POLL_INTERVAL:-"15"}
if [ "$CONTEST_ID" = "DEFAULT" ]
then
    # poll until a contest has been discovered
    while [ $? -eq 0 ]
    do
        # autoselect default contest
        printf "\n" | ./scripts/cmsProxyService 0

        echo "Service ProxyService waiting for a contest to be created..."
        sleep $POLL_INTERVAL
    done
else
    exec ./scripts/cmsProxyService --contest-id $CONTEST_ID 0
fi