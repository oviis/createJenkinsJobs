#!/bin/bash

jobName=$1

# if `docker run` first argument start with `-` the user is passing jenkins swarm launcher arguments
if [[ $# -lt 1 ]] ; then
  echo -e "\n=== please provide a jenkins Job Name as a run parameter=== \n"
  exit 22
else
  sed -i "s&@@@jobName@@@&$jobName&g" template_config.xml
  curl -d @template_config.xml -H 'Content-Type: text/xml' "http://localhost:8080/createItem?name=$jobName"
  sed -i "s&$jobName&@@@jobName@@@&g" template_config.xml
fi