FROM rubygem/cf-uaac

ADD create-user.sh /tmp/create-user.sh
RUN chmod +x /tmp/create-user.sh
ENTRYPOINT /tmp/create-user.sh
