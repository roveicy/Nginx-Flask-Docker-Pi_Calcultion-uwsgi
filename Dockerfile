FROM alpine:latest

RUN apk --update --no-cache add \
        apache2-utils \
        bash \
        bc

ADD abtest/abtest.sh /usr/bin/abtest 
RUN chmod a+x /usr/bin/abtest
RUN mkdir /app 
RUN echo -e "10\n100" > /app/users.list

ENV TEST_URL http://127.0.0.1/100
ENV TEST_SLEEP 20
ENV TEST_PERIOD 60

WORKDIR /app

ENTRYPOINT [ "/usr/bin/abtest" ]
