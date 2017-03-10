#!/bin/bash

# This function will be useful when we need to retry things
function retry () {
    max=${1}
    delay=${2}
    msg=${3}
    shift 3

    for i in $(seq "${max}")
    do
        echo "${msg}"
        eval "$@" && return 0 || sleep "${delay}"
    done

    return 1
}

retry 10 5 'Waiting to target UAA...' "uaac target $UAA_ENDPOINT --skip-ssl-validation"
echo "UAA target on $HCF_UAA_ENDPOINT succeeded"


retry 5 2 'Authenticating admin user...' "uaac token client get $UAA_CLIENT -s $UAA_SECRET"
echo "Authentication of admin user succeeded"


#check if client already exists
uaac client get $UAA_CLIENT_NAME

if [ "$?" = "0" ] ; then
	echo "client $UAA_CLIENT_NAME already exists"
	
	uaac client delete $UAA_CLIENT_NAME
fi

echo "Creating client $UAA_CLIENT_NAME ..."
uaac client add $UAA_CLIENT_NAME -s $UAA_CLIENT_SECRET --authorities $NEW_AUTHORITIES --authorized_grant_types client_credentials
