FROM python:3.6-slim-bullseye

RUN apt-get update \
    && apt-get --no-install-recommends -y install unzip libaio1 python3-dev libc-dev gcc \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt/data

WORKDIR /opt/data

ADD ./oracle-instantclient/ /opt/data

RUN unzip instantclient-basic-linux.x64-12.2.0.1.0.zip -d /opt/oracle \
    && unzip instantclient-sdk-linux-12.2.0.1.0 -d /opt/oracle \
    && rm -rf /opt/data/* \
    && mv /opt/oracle/instantclient_12_2 /opt/oracle/instantclient \
    && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
    && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so


ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME
ENV PATH=$PATH:$ORACLE_HOME

ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include

CMD ["python3"]