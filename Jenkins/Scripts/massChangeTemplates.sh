#!/bin/bash
#
# При изменении шаблонов пайплайнов сканеров, скрипт обновит их во всех каталога с джобами
#

find /var/lib/jenkins/jobs -type d -name "1_Gitleaks" -exec cp -ur /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/jobs/1_Gitleaks/* {} \;
find /var/lib/jenkins/jobs -type d -name "2_Semgrep" -exec cp -ur /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/jobs/2_Semgrep/* {} \;
find /var/lib/jenkins/jobs -type d -name "3_Cdxgen" -exec cp -ur /var/lib/jenkins/jobs/0_TEMPLATE_SCANNERS/jobs/3_Cdxgen/* {} \;
