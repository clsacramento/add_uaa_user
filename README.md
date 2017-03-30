# add_uaa_user
Docker image that creates a user on UAA

## How to build

~~~
docker build -t add_uaa_user .
~~~

## How to run

Replace the following variable according to your system
~~~
cat <<EOF > uaavars
UAA_ENDPOINT=https://uaa.domain.cf:443
UAA_CLIENT=admin_client
UAA_SECRET=adminsecret
UAA_CLIENT_NAME=new_client_to_create
UAA_CLIENT_SECRET=newclientsecret
NEW_AUTHORITIES=cloud_controller.admin,doppler.firehose
EOF
~~~

Docker run the image using the created file

~~~
docker run --env-file uaavars add_uaa_user
~~~

## For debug

Execute the container with /bin/bash to debug things or just use the uaac

~~~
$ docker run --entrypoint="/bin/bash" --env-file uaavars add_uaa_user
root@60dc98f6b02a:/tmp# uaac target $UAA_ENDPOINT --skip-ssl-validation

Target: https://uaa.domain.cf

root@60dc98f6b02a:/tmp# 
root@60dc98f6b02a:/tmp# uaac token client get $UAA_CLIENT -s $UAA_SECRET

Successfully fetched token via client credentials grant.
Target: https://uaa.domain.cf
Context: admin_client, from client admin_client

root@60dc98f6b02a:/tmp# #add your commands here

~~~
