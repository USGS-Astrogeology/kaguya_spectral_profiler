FROM jupyter/scipy-notebook

USER root

# Spark dependencies
ENV APACHE_SPARK_VERSION 2.2.0
ENV HADOOP_VERSION 2.7
ENV HBASE_VERSION 1.2.6

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp && \
        wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
        echo "7a186a2a007b2dfd880571f7214a7d329c972510a460a8bdbef9f7f2a891019343c020f74b496a61e5aa42bc9e9a79cc99defe5cb3bf8b6f49c07e01b259bc6b *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

# update jupyter
RUN conda install jupyterlab


# Spark
ENV SPARK_HOME /usr/local/spark

# Inject additional jars
COPY shc-core-1.1.2-2.2-s_2.11.jar /usr/local/spark/jars/shc-core-1.1.2-2.2-s_2.11.jar

# Download and inject the HBase jars as well
RUN wget http://apache.claz.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    tar xzf hbase-${HBASE_VERSION}-bin.tar.gz -C /usr/local && \
    rm hbase-${HBASE_VERSION}-bin.tar.gz

ENV HBASE_HOME = /usr/local/hbase-${HBASE_VERSION} 
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip

ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

COPY hbase-site.xml ${SPARK_HOME}/conf/hbase-site.xml
COPY Spark_HBase.ipynb /home/jovyan/Spark_HBase.ipynb
RUN chown jovyan:users /home/jovyan/Spark_HBase.ipynb
