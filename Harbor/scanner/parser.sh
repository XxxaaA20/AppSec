#!/bin/bash

echo "     === Parsing file $1 ==="

# Get ArtifactName line value for next parsing
line=$(sed -n 's/"ArtifactName": "\(.*\)@sha.*/\1/p' $1)

# Get hostname from line
host=$(echo "$line" | sed -n 's;/.*;;p')

# Get namespace from line
namespace=$(echo "$line" | sed -n 's;[^/]*/\([^/]*\)/.*$;\1;p')
echo "Namespace -- $namespace"


# Get image from line
var=$(echo "$line" | sed -n 's;[^/]*/\(.*\);\1;p')
image=$(echo "$var" | sed -n 's;[^/]*/\(.*\);\1;p')
echo "Image -- $image"

echo "     === Send result to DefectDOJO ==="
echo "Product_name --- $namespace"
echo "engagement_name --- $image"

curl -X POST "https://your-defectdojo-url/api/v2/reimport-scan/" \
-H "accept: application/json" \
-H "Authorization: Token <your-token>" \
-H "Content-Type: multipart/form-data" \
-H "X-CSRFToken: <your-token>" \
-F "product_type_name=Harbor Trivy Scans" \
-F "active=true" \
-F "endpoint_to_add=" \
-F "verified=false" \
-F "close_old_findings=true" \
-F "test_title=" \
-F "engagement_name=$image" \
-F "build_id=" \
-F "deduplication_on_engagement=true" \
-F "push_to_jira=false" \
-F "minimum_severity=Info" \
-F "scan_date=" \
-F "environment=" \
-F "service=" \
-F "commit_hash=" \
-F "group_by=" \
-F "version=" \
-F "tags=string" \
-F "api_scan_configuration=" \
-F "product_name=$namespace" \
-F "file=@$1" \
-F "auto_create_context=true" \
-F "lead=" \
-F "scan_type=Trivy Scan" \
-F "branch_tag=" \
-F "engagement="

echo "File $1 successfuly send to DefectDOJO. Deleting..."
rm -rf $1
echo "File deleted!"