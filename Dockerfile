FROM python:3.9-alpine3.13
LABEL maintainer="sarangp"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
RUN mkdir /app
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp
    # adduser \ 
    #     --disabled-password \
    #     --gecos "" \
    #     --home /app \
    #     django-user



ENV PATH="/py/bin:$PATH"
#     RUN chown django-user:django-user -R /app
# # RUN chmod +x /app
#     USER django-user

