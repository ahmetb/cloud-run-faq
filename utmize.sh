#!/bin/bash
set -euo pipefail

utm_query='utm_campaign=CDR_ahm_aap-severless_cloud-run-faq_\&utm_source=external\&utm_medium=web'
sed -i'' -E "/utm_/!s/(https:\/\/cloud.google.com\\/[^)#\?]*)/\\1?${utm_query}/g" README.md

