#!/bin/bash
export PYTHONPATH=/app
cd /app
mkdir /var/log/isamples
export ORCID_TOKEN_SECRET=`cat /run/secrets/orcid_token_secret`
declare DATE=$(date "+%Y-%m-%d")
declare OUTPUT_DIR="/app/sitemaps/$DATE/sitemaps"
echo "Attempting to remove sitemap directory output at $OUTPUT_DIR, ok if this fails"
rm -rf $OUTPUT_DIR
echo "Creating sitemap directory output at $OUTPUT_DIR"
mkdir -p $OUTPUT_DIR
echo "Invoking sitemap creation script, using sitemap prefix of $ISB_SITEMAP_PREFIX"
curl "http://localhost:8000/export/create_sitemap" -H "Authorization: Bearer $ORCID_TOKEN_SECRET"
echo "Removing old sitemaps symlink"
rm -rf /app/isb_web/sitemaps
echo "Creating new sitemaps symlink"
ln -s $OUTPUT_DIR /app/isb_web/