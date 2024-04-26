#!/bin/sh

set -e

/home/scanner/install_cert.sh

/home/scanner/inotifywait.sh &
/home/scanner/inotifywaitdel.sh &

exec /home/scanner/bin/scanner-trivy