#!/bin/bash

# replace filebeat.yml params...
#sed 

echo "filebeat 5.0.0 starting ..."
/usr/share/filebeat/bin/filebeat -e -c "/etc/filebeat/filebeat.yml"
echo "filebeat 5.0.0 started ..."