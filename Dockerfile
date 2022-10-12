#FROM ubuntu:18.10
FROM ubuntu:20.04

ARG ZEPPELIN_VERSION="0.10.1"
ARG SPARK_VERSION="2.4.8"
ARG HADOOP_VERSION="2.7"

LABEL maintainer "clouddood"
LABEL zeppelin.version=${ZEPPELIN_VERSION}
LABEL spark.version=${SPARK_VERSION}
LABEL hadoop.version=${HADOOP_VERSION}

# Install Java and some tools
RUN apt-get -y update &&\
    apt-get -y install curl less &&\
    apt-get install -y openjdk-8-jdk &&\
    apt-get install -y python3-pip &&\
    apt-get install -y wget &&\
    apt-get install -y unzip &&\
    apt-get install -y net-tools &&\
    apt-get -y install vim


##########################################
# SPARK
##########################################
ARG SPARK_ARCHIVE=https://archive.apache.org/dist/spark/spark-2.4.8/spark-2.4.8-bin-hadoop2.7.tgz
RUN mkdir /usr/local/spark &&\
    mkdir /tmp/spark-events    # log-events for spark history server
ENV SPARK_HOME /usr/local/spark

ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -s ${SPARK_ARCHIVE} | tar -xz -C  /usr/local/spark --strip-components=1

RUN echo "spark.eventlog.enabled  true" >> ${SPARK_HOME}/conf/spark-defaults.conf
RUN echo "SPARK_LOCAL_IP=0.0.0.0" >> ${SPARK_HOME}/conf/spark-env.sh
#COPY spark-defaults.conf ${SPARK_HOME}/conf/


##########################################
# Zeppelin
##########################################
RUN mkdir /usr/zeppelin &&\
    curl -s https://dlcdn.apache.org/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz | tar -xz -C /usr/zeppelin

RUN echo '{ "allow_root": true }' > /root/.bowerrc

#ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_PORT 8989
ENV ZEPPELIN_ADDR="0.0.0.0"
EXPOSE $ZEPPELIN_PORT

ENV ZEPPELIN_HOME /usr/zeppelin/zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook

RUN mkdir -p $ZEPPELIN_HOME \
  && mkdir -p $ZEPPELIN_HOME/logs \
  && mkdir -p $ZEPPELIN_HOME/run

# Make DataDir and Add Example Data
RUN \
  mkdir -p  /mnt/zeppelin_DataDir && \
  cd /mnt/zeppelin_DataDir && \
  wget http://archive.ics.uci.edu/ml/machine-learning-databases/00222/bank.zip && \
  unzip bank.zip

# my WorkDir
RUN mkdir /work
WORKDIR /work


ENTRYPOINT  /usr/local/spark/sbin/start-history-server.sh; $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start  && bash

##########################################
# H2O.ai & Sparkling Water
##########################################

# Fetch h2o latest_stable
RUN \
  wget http://h2o-release.s3.amazonaws.com/h2o/latest_stable -O latest && \
  wget -i latest -O /opt/h2o.zip && \
  unzip -d /opt /opt/h2o.zip && \
  rm /opt/h2o.zip && \
  cd /opt && \
  cd `find . -name 'h2o.jar' | sed 's/.\///;s/\/h2o.jar//g'` && \
  cp h2o.jar /opt && \
  /usr/bin/pip install `find . -name "*.whl"` && \
  printf '!/bin/bash\ncd /home/h2o\n./start-h2o-docker.sh\n' > /start-h2o-docker.sh && \
  chmod +x /start-h2o-docker.sh

RUN \
  useradd -m -c "h2o.ai" h2o

#USER h2o

# Get Content
RUN \
  cd && \
  wget https://raw.githubusercontent.com/h2oai/h2o-3/master/docker/start-h2o-docker.sh && \
  chmod +x start-h2o-docker.sh && \
# wget http://s3.amazonaws.com/h2o-training/mnist/train.csv.gz && \
  wget https://github.com/h2oai/h2o-2/raw/master/smalldata/mnist/train.csv.gz && \
  gunzip train.csv.gz

# Create a tmp DataDir
RUN \
  mkdir /mnt/DataDir

# Define a mountable data directory
#VOLUME \
#  ["/data"]

# Define the working directory
#WORKDIR \
#  /home/h2o

# Get Sparkling Water
RUN \
  cd /opt && \
  wget https://s3.amazonaws.com/h2o-release/sparkling-water/spark-2.4/3.38.0.1-1-2.4/sparkling-water-3.38.0.1-1-2.4.zip && \
  unzip sparkling-water-3.38.0.1-1-2.4.zip && \
  chown h2o -R sparkling-water*
# unzip sparkling-water-3.38.0.1-1-2.4.zip && \
# cd sparkling-water-3.38.0.1-1-2.4 && \
# bin/sparkling-shell --conf "spark.executory.memory=1g"

EXPOSE 54321
EXPOSE 54322

#ENTRYPOINT ["java", "-Xmx4g", "-jar", "/opt/h2o.jar"]
# Define default command

CMD \
  ["/bin/bash"]

