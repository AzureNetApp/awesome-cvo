#!/usr/bin/env bash

# ==========================================================================================================
# Colored Printing
# ==========================================================================================================

__RAINBOWPALETTE="1"
COLOR_ESCAPE="\e"
if [[ "$IS_MAC" == true ]]; then
  COLOR_ESCAPE="\033"
fi

function __colortext() {
  echo -e " $COLOR_ESCAPE[$__RAINBOWPALETTE;$2m$1$COLOR_ESCAPE[0m"
}

function echored() {
  echo $(__colortext "ERROR: $1" "31")
}

function echogreen() {
  echo $(__colortext "$1" "32")
}

function echoyellow() {
  echo $(__colortext "$1" "33")
}

Help()
{
   # Display Help
   echoyellow "Data Sense site survey tool"
   echo "tool checks prerequistis such as CPU, RAM, Disk, OS features, URL connrecity and more"
   echo
   echoyellow "Syntax: ./netapp_cloud_site_survey_tool.sh [-p|h|m cm/ds]"
   echo "options:"
   echo "-p, --provider     Choose relevant provider aws/azure/gcp/onprem - default onprem"
   echo "-m, --mode         Choose relevant service mode cm- cloud manager/ ds- data sense - default ds"
   echo "-h, --help         Print this Help."
   echo
}

PROVIDER=onprem
MODE=ds

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -p | --provider)
    PROVIDER="$2"
    shift # past argument
    shift # past value
    ;;
  -m | --mode)
    MODE="$2"
    shift # past argument
    shift # past value
    ;;
  -h | --help)
    Help
    exit 0
    ;;
  *)
    # unknown option
    shift # past argument with no value
    ;;

  esac
done

function test_urls() {
  for url in "${urls_to_test[@]}"; do
    response=$(curl --write-out '%{http_code}' --silent --output /dev/null $url)
    if [[ $response == 000 ]]; then
      echored "Failed to connect to $url $response"
    else
      echogreen "Connected to $url successfully"
    fi
  done
}

if [ $MODE == "ds" ]; then
  MIN_MEMORY=62000000 # KB, ~60 GB
  MINIMAL_CORES=8
  MINIMAL_DISK=102000000 # KB, ~100 GB
  RHEL_8_SUPPORTED=1
elif [ $MODE == "cm" ]; then
  MIN_MEMORY=14000000 # KB, ~14 GB
  MINIMAL_CORES=4
  MINIMAL_DISK=102000000 # KB, ~100 GB
else
  echored "invalid mode!"
  exit 1
fi

case $PROVIDER in
    aws|gcp|azure|onprem) echo ;;
    *)             echored "Invalid Provider"; exit 1;
esac

echoyellow "*********************************"
echogreen "NetApp Cloud Site Survey Tool"
echoyellow "*********************************"

echo
echoyellow "use --help for details and execution options"
echo
echo "[+] Validating System Prerequisits"
echo

if [ $(awk '/^MemTotal:/ { print $2; }' /proc/meminfo) -lt $MIN_MEMORY ]; then
  echored "Memory is below minimal $MIN_MEMORY (KB) requirement"
  echo
else
  echogreen "Memory validation passed"
  echo
fi

if [ $(nproc) -lt $MINIMAL_CORES ]; then
  echored "$(nproc) CPUs is less than minimal requirement of $MINIMAL_CORES"
  echo
else
  echogreen "CPU validation passed"
  echo
fi

if [ $MODE == "ds" ]; then
  cat /proc/cpuinfo | grep -q avx2 || echored "CPU/firmware version is old - upgrade to one supporting avx2"
fi

if [ $(df --output=avail /var/lib | sed '1d;s/[^0-9]//g') -lt $MINIMAL_DISK ]; then
  echored "Available disk space is less than minimal $MINIMAL_DISK KB requirement"
  echo
else
  echogreen "Disk validation passed"
  echo
fi

if [[ $(rpm -E %{rhel}) == 8 ]] && [ -z "$RHEL_8_SUPPORTED" ]; then
  echored "Unsupported RHEL OS version"
else
  echogreen "OS version validation passed"
  echo
fi

declare -a urls_to_test=("https://cloudmanager.cloud.netapp.com/cloud-compliance/health"
  "https://netapp-cloud-account.auth0.com"
  "https://auth.docker.io"
  "https://registry-1.docker.io"
  "https://index.docker.io"
  "https://dseasb33srnrn.cloudfront.net"
  "https://production.cloudflare.docker.com"
  "https://support.compliance.cloudmanager.cloud.netapp.com"
)

echo "[+] Testing firewalld"
systemctl is-active --quiet firewalld && echoyellow "Firewalld is enabled - please disable service prior to installation" || echogreen "Firewalld is disabled"
echo

if [ $MODE == "ds" ]; then
  echo "[+] Testing Data Sense URL connectivity"
  test_urls
fi

if [ $MODE == "cm" ]; then

  echo
  echo "[+] Testing Cloud Manager ($PROVIDER) URL connectivity"

  if [[ $PROVIDER == "aws" ]]; then
    declare -a urls_to_test=("https://api.services.cloud.netapp.com"
      "https://s3.us-west-1.amazonaws.com"
      "https://cognito-idp.us-east-1.amazonaws.com"
      "https://cognito-identity.us-east-1.amazonaws.com"
      "https://sts.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.amazonaws.com"
      "https://cloudmanagerinfraprod.azurecr.io"
      "https://kinesis.us-east-1.amazonaws.com"
      "https://cloudmanager.cloud.netapp.com"
      "https://netapp-cloud-account.auth0.com"
      "https://mysupport.netapp.com"
      "https://support.netapp.com/svcgw"
      "https://support.netapp.com/ServiceGW/entitlement"
      "https://cloud-support-netapp-com.s3.us-west-1.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.us-west-1.amazonaws.com"
      "https://ipa-signer.cloudmanager.netapp.com"
    )
  elif [[ $PROVIDER == "azure" ]]; then
    declare -a urls_to_test=("https://management.azure.com"
      "https://login.microsoftonline.com"
      "https://management.microsoftazure.de"
      "https://login.microsoftonline.de"
      "https://management.usgovcloudapi.net"
      "https://login.microsoftonline.com"
      "https://api.services.cloud.netapp.com"
      "https://cognito-idp.us-east-1.amazonaws.com"
      "https://cognito-identity.us-east-1.amazonaws.com"
      "https://sts.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.amazonaws.com"
      "https://cloudmanagerinfraprod.azurecr.io"
      "https://kinesis.us-east-1.amazonaws.com"
      "https://cloudmanager.cloud.netapp.com"
      "https://netapp-cloud-account.auth0.com"
      "https://mysupport.netapp.com"
      "https://support.netapp.com"
      "https://client.infra.support.netapp.com.s3.us-west-1.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.us-west-1.amazonaws.com"
      "https://ipa-signer.cloudmanager.netapp.com"
    )
  elif [[ $PROVIDER == "gcp" ]]; then
    declare -a urls_to_test=("https://www.googleapis.com"
      "https://api.services.cloud.netapp.com"
      "https://cognito-idp.us-east-1.amazonaws.com"
      "https://cognito-identity.us-east-1.amazonaws.com"
      "https://sts.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.amazonaws.com"
      "https://cloudmanagerinfraprod.azurecr.io"
      "https://kinesis.us-east-1.amazonaws.com"
      "https://cloudmanager.cloud.netapp.com"
      "https://netapp-cloud-account.auth0.com"
      "https://mysupport.netapp.com"
      "https://support.netapp.com"
      "https://cloud-support-netapp-com.s3.us-west-1.amazonaws.com"
      "https://client.infra.support.netapp.com.s3.us-west-1.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.us-west-1.amazonaws.com"
      "https://ipa-signer.cloudmanager.netapp.com"
    )
  elif [[ $PROVIDER == "onprem" ]]; then
    declare -a urls_to_test=("https://api.services.cloud.netapp.com"
      "https://s3.us-west-1.amazonaws.com"
      "https://cognito-idp.us-east-1.amazonaws.com"
      "https://cognito-identity.us-east-1.amazonaws.com"
      "https://sts.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.amazonaws.com"
      "https://cloudmanagerinfraprod.azurecr.io"
      "https://kinesis.us-east-1.amazonaws.com"
      "https://cloudmanager.cloud.netapp.com"
      "https://netapp-cloud-account.auth0.com"
      "https://mysupport.netapp.com"
      "https://support.netapp.com/svcgw"
      "https://support.netapp.com/ServiceGW/entitlement"
      "https://cloud-support-netapp-com.s3.us-west-1.amazonaws.com"
      "https://cloud-support-netapp-com-accelerated.s3.us-west-1.amazonaws.com"
      "https://ipa-signer.cloudmanager.netapp.com"
      "https://dev.mysql.com"
      "https://dl.fedoraproject.org/pub",
      "https://test.blob.core.windows.net"
    )
  fi

  test_urls
fi

if [ $MODE == "ds" ]; then
  echo
  echo "[+] Testing Data Sense -> Cloud Manager connectivity"

  while [ -z "$CM_HOST" ]; do
    echo
    echo "Please enter valid IP or host name for the Cloud Manager connector instance"
    echo "that will have access from this current Data Sense Data Connector instance"
    echo
    read -p 'Cloud Manager connector relevant IP or Host: ' CM_HOST
  done

  timeout 1 bash -c "cat < /dev/null > /dev/tcp/${CM_HOST}/80"
  res=$(echo $?)

  if [ $res == 0 ]; then
    echogreen "Connected to Cloud Manager connector successfully"
  elif [ $res == 124 ]; then
    echored "could not connect to Cloud Manager connector"
  elif [ $res == 1 ]; then
    echoyellow "Could connect to Cloud Manager connector - yet it does not listen on port 80"
  fi
fi
