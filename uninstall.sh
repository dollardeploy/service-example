#!/bin/bash
set -e

# uninstall.sh runs once when the service is removed (on the next prepare),
# then ~/services/example is deleted. Keep it tolerant of partial installs.

echo "example: uninstalling"

# Remove the software we installed. Use || true so a missing package or a
# host that never finished installing doesn't fail the whole prepare.
sudo apt-get purge -y jq || true
sudo apt-get autoremove -y || true

echo "example: uninstall complete"
