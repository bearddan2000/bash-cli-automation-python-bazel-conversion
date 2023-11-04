FROM alpine:latest as builder

WORKDIR /app

COPY bin/requirements.txt .

COPY bin/requirements.py .

COPY bin/BUILD .

RUN apk update \
    && apk add python3 py-pip

RUN pip install pip-tools

RUN mv requirements.txt requirements.in \
    && pip-compile --strip-extras

# custom script
# 1. cleans requirements.txt of comments
# 2. copies requirements to BUILD
RUN python3 requirements.py

FROM l.gcr.io/google/bazel:latest

# this image is ubuntu based
# bazel provides python compiler we need pip
RUN apt update \
    && apt install -y python3-pip

WORKDIR  /src/workspace

COPY bin .

COPY --from=builder /app/BUILD .

COPY --from=builder /app/requirements.txt .

# still need to install requirements even though listed in BUILD
RUN pip3 install -r requirements.txt

# just good practice
RUN bazel clean

RUN bazel run :main

CMD [""]
