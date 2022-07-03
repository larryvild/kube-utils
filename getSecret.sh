#!/bin/bash

getSecretsNames(){
  namespace=$1
  secretNamePattern=$2

  ([ -z "${namespace}" ] || [ -z "${secretNamePattern}" ]) \
    && echo "Err: Please provide non-empty namespace and secretNamePattern in input" \
    && exit 2

  echo `kubectl get secrets -n ${namespace} | awk '{print $1}' | grep -e ${secretNamePattern}` 
}

writeSecretsToJson(){
  namespace=$1
  secretNameList=$2

  ([ -z "${namespace}" ] || [ -z "${secretNamePattern}" ]) \
    && echo "Err: Please provide non-empty namespace and secretNamePattern in input" \
    && exit 2
  
  for secretName in "${secretNameList}"
  do
    stringKeyVal=`kubectl get secret "${secretName}" -o jsonpath='{.data}'`
    echo '{' > ${secretName}.json

  done
}

secretNameList=`getSecretsNames $1 $2`
echo $secretNameList

