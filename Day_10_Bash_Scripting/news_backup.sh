#!/bin/bash
#################################
# Author: Mohd Afsar Hussain
# Date: 28-01-2026
#
#
# Script to zip static website and store in this server and in backup server
#############################

set +x
set -e

ZIP_NAME="xfusioncorp_news.zip"
WEBSITE_PAGES_PATH="/var/www/html/news"
LOCAL_FOLDER="/backup/"
BACKUP_SERVER_USER="clint"
BACKUP_SERVER="stbkp01"
BACKUP_SERVER_REMOTE_PATH="/backup/"

echo "zipping the files ...."

zip -r ${LOCAL_FOLDER}${ZIP_NAME} ${WEBSITE_PAGES_PATH}

echo "Copying to remote server..."

scp ${LOCAL_FOLDER}${ZIP_NAME} ${BACKUP_SERVER_USER}@${BACKUP_SERVER}:${BACKUP_SERVER_REMOTE_PATH}

echo "Backup done and copied to remote server"
