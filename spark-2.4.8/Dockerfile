#FROM ubuntu:18.10
#FROM ubuntu:20.04
FROM alpine:3.14
#FROM clouddood/hadoop2.7.3:v1 


##########################################
# Hadoop
##########################################
# Setup Oracle Java
##  RUN \
##    pip install gdown 
##  
##  RUN \
##    cd /usr/lib/jvm && \
##  # curl -s http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-i586.tar.gz
##    gdown https://drive.google.com/uc?id=16BCBMKto7XDt_fon_Pj2YD4iDfd_uBkR && \
##    tar -xf jdk-8u341-linux-x64.tar.gz 
##  
##  #ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_341
##  
##  RUN curl -s https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz | tar -xz -C /usr/local/
##  RUN cd /usr/local && ln -s ./hadoop-2.7.7 hadoop
##  
##  ENV HADOOP_PREFIX /usr/local/hadoop
##  ENV HADOOP_COMMON_HOME /usr/local/hadoop
##  ENV HADOOP_HDFS_HOME /usr/local/hadoop
##  ENV HADOOP_MAPRED_HOME /usr/local/hadoop
##  ENV HADOOP_YARN_HOME /usr/local/hadoop
##  ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
##  ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
##  
##  #RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/default\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
##  ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_341
##  ENV HADOOP_HOME=/usr/local/hadoop
##  
##  RUN mkdir /var/log/hadoop
##  ENV HADOOP_LOG_DIR=/var/log/hadoop
##  
##  #RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
##  #RUN . $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
##  
##  #RUN mkdir $HADOOP_PREFIX/input
##  RUN mkdir /usr/local/hadoop/input
##  RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input
##  
##  # pseudo distributed
##  #ADD hadoop_files/core-site.xml.template $HADOOP_PREFIX/etc/hadoop/core-site.xml.template
##  #RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml
##  ADD hadoop_files/core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
##  ADD hadoop_files/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
##  
##  ADD hadoop_files/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
##  ADD hadoop_files/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
##  
##  RUN $HADOOP_PREFIX/bin/hdfs namenode -format > /tmp/hdfs_format.log
##  
##  # fixing the libhadoop.so like a boss
##  #RUN rm -rf /usr/local/hadoop/lib/native
##  #RUN mv /tmp/native /usr/local/hadoop/lib
##  
##  # ssh configuration
##  ADD hadoop_files/ssh_config /root/.ssh/config
##  RUN chmod 600 /root/.ssh/config
##  RUN chown root:root /root/.ssh/config
##  
##  # # installing supervisord
##  # RUN yum install -y python-setuptools
##  # RUN easy_install pip
##  # RUN curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -o - | python
##  # RUN pip install supervisor
##  #
##  # ADD supervisord.conf /etc/supervisord.conf
##  
##  ADD hadoop_files/bootstrap.sh /etc/bootstrap.sh
##  RUN chown root:root /etc/bootstrap.sh
##  RUN chmod 700 /etc/bootstrap.sh
##  
##  ENV BOOTSTRAP /etc/bootstrap.sh
##  
##  # workingaround docker.io build error
##  RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
##  RUN chmod +x /usr/local/hadoop/etc/hadoop/*-env.sh
##  RUN ls -la /usr/local/hadoop/etc/hadoop/*-env.sh
##  
##  # fix the 254 error code
##  #RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
##  #RUN echo "UsePAM no" >> /etc/ssh/sshd_config
##  #RUN echo "Port 2122" >> /etc/ssh/sshd_config
##  
##  #RUN service sshd start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
##  #RUN $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
##  #RUN service sshd start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input
##  #RUN $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input
##  
##  CMD ["/etc/bootstrap.sh", "-d"]

# Hdfs ports
#EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
#EXPOSE 10020 19888
#Yarn ports
#EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
#EXPOSE 49707 2122


##########################################
# Hive 2 
##########################################

ARG HIVE_VERSION
# Set HIVE_VERSION from arg if provided at build, env if provided at run, or default
# https://docs.docker.com/engine/reference/builder/#using-arg-variables
# https://docs.docker.com/engine/reference/builder/#environment-replacement
ENV HIVE_VERSION=${HIVE_VERSION:-2.3.2}

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

WORKDIR /opt

#Install Hive and PostgreSQL JDBC
RUN apt-get update && apt-get install -y wget procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


#Spark should be compiled with Hive to be able to use it
#hive-site.xml should be copied to $SPARK_HOME/conf folder

#Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh

##########################################
# SPARK
##########################################
# builder step used to download and configure spark environment
FROM openjdk:8 as builder

# Add Dependencies for PySpark
RUN apt-get update && apt-get install -y curl vim wget software-properties-common ssh net-tools ca-certificates python3 python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas
#RUN apt-get update && apt-get install -y curl vim wget software-properties-common ssh net-tools ca-certificates python3 python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas python3-simpy

RUN update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV SPARK_VERSION=2.4.8 \
HADOOP_VERSION=2.7 \
SPARK_HOME=/opt/spark \
PYTHONHASHSEED=1

# Download and uncompress spark from the apache archive
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
&& mkdir -p /opt/spark \
&& tar -xf apache-spark.tgz -C /opt/spark --strip-components=1 \
&& rm apache-spark.tgz


# Apache spark environment
FROM builder as apache-spark

WORKDIR /opt/spark

ENV SPARK_MASTER_PORT=7077 \
SPARK_MASTER_WEBUI_PORT=8080 \
SPARK_LOG_DIR=/opt/spark/logs \
SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
SPARK_WORKER_WEBUI_PORT=8080 \
SPARK_WORKER_PORT=7000 \
SPARK_MASTER="spark://spark-master:7077" \
SPARK_WORKLOAD="master"

EXPOSE 8080 7077 6066

RUN mkdir -p $SPARK_LOG_DIR && \
touch $SPARK_MASTER_LOG && \
touch $SPARK_WORKER_LOG && \
ln -sf /dev/stdout $SPARK_MASTER_LOG && \
ln -sf /dev/stdout $SPARK_WORKER_LOG

COPY start-spark.sh /

#RUN mkdir /opt/spark-apps && \
ADD apps /opt/spark-apps

CMD ["/bin/bash", "/start-spark.sh"]

##########################################
# Zeppelin
##########################################
 
ARG ZEPPELIN_VERSION="0.10.1"
ARG SPARK_VERSION="2.4.8"
ARG HADOOP_VERSION="2.7"

LABEL zeppelin.version=${ZEPPELIN_VERSION}
LABEL spark.version=${SPARK_VERSION}

RUN apt-get install -y unzip zip

RUN mkdir /opt/zeppelin && \
    cd /opt/zeppelin && \
#   curl -s https://dlcdn.apache.org/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
    wget https://dlcdn.apache.org/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
    tar -xf zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz

RUN echo '{ "allow_root": true }' > /root/.bowerrc

#ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_PORT 8989
ENV ZEPPELIN_ADDR="0.0.0.0"
EXPOSE $ZEPPELIN_PORT

ENV ZEPPELIN_HOME /opt/zeppelin/zeppelin-${ZEPPELIN_VERSION}-bin-all
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
## 
## # my WorkDir
## RUN mkdir /work
## WORKDIR /work


#ENTRYPOINT  /opt/spark/sbin/start-history-server.sh; $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start  && bash

##########################################
# H2O.ai & Sparkling Water
##########################################
RUN apt install python3-pip unzip

# Fetch h2o latest_stable
RUN \
  wget http://h2o-release.s3.amazonaws.com/h2o/latest_stable -O latest && \
  wget -i latest -O /opt/h2o.zip && \
  unzip -d /opt /opt/h2o.zip && \
  rm /opt/h2o.zip && \
  cd /opt && \
  cd `find . -name 'h2o.jar' | sed 's/.\///;s/\/h2o.jar//g'` && \
  cp h2o.jar /opt && \
  /usr/bin/pip3 install `find . -name "*.whl"` && \
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

# Git clone sparkling-water for examples
RUN \
  cd /tmp && \
  git clone https://github.com/h2oai/sparkling-water.git
  
# Install sdkman and gradle
#RUN \
#  curl -s "https://get.sdkman.io" | bash && \
# source "$HOME/.sdkman/bin/sdkman-init.sh" && \
# sdk install gradle

 
## # Define a mountable data directory
## #VOLUME \
## #  ["/data"]
## 
## # Define the working directory
## #WORKDIR \
## #  /home/h2o
## 
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
## 
## #ENTRYPOINT ["java", "-Xmx4g", "-jar", "/opt/h2o.jar"]
## # Define default command
## 
## CMD \
##   ["/bin/bash"]

