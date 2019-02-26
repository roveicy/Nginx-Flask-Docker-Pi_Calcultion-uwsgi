FROM alpine:latest

RUN apk --update --no-cache add \
        apache2-utils \
        bash \
        bc

ADD abtest /app

ENV TEST_URL http://127.0.0.1/
ENV TEST_SLEEP 20
ENV TEST_PERIOD 60

WORKDIR /app

ENTRYPOINT [ "/bin/bash" ]
CMD ["/app/abtest.sh"]
