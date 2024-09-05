FROM chainguard/python:latest-dev
# By default, package manager operations like apt-get update or yum install require root privileges. So set it as below before running any package update
USER root       
RUN apk update
