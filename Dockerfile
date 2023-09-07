FROM python:3.9-alpine3.13
LABEL maintainer="sarangp"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
RUN mkdir /app
COPY ./app /app
WORKDIR /app
EXPOSE 8080

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --uodate --no-cache postgresql-client && \
    apk add --uodate --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp &&\
    apk del .tmp-build-deps
    # adduser \ 
    #     --disabled-password \
    #     --gecos "" \
    #     --home /app \
    #     django-user



ENV PATH="/py/bin:$PATH"
#     RUN chown django-user:django-user -R /app
# # RUN chmod +x /app
#     USER django-user

