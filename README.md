# dev_SparkAIO
AIO Spark Build

#### Components to Includes:
- Hadoop
- Spark - YES
- Hive
- HBase
- Pig
- Flume
- Tez
- Zeppelin - YES
- H2O - YES
  - h2o sparkling water - YES
- ODBC
- JDBC

#### Docker AIO with Hadoop, Spark, H2O
- Build image
  ```
  $docker build -t spark2.4.8:v1 -f <path>/Dockerfile .
  ```

- Launch Command:
  Port Maps: 
  - 4040-4044: Spark Job Monitoring
  - 18080 : Spark Log Server
  - 18989 : Zeppelin
  - 54321 : H2O

  ```
  ## H2O
  $docker run -it --rm -p 18080:18080 -p 18989:8989 -p 54321:54321 <image_id> bash 
  root@<image_id>:/workdir$cd /opt/h2o-3.38.0.1
  root@<image_id:/opt/h2o-3.38.0.1$java -jar h2o.jar &
  ## Should now be able to open http://localhost:54321 in browser

  ## Mount Volume Local (/tmp/h2o_datadir) to Container (/mnt/DataDir)
  $docker run -it --rm -p 18080:18080 -p 18989:8989 -p 54321:54321 -v /tmp/h2o_datadir:/mnt/DataDir <image_id> bash
  ```
- Launch Container Services: (docker-compose)
  ```
  ## Build docker image
  $docker build -t spark-base:2.4.8 -f ./spark-2.4.8/Dockerfile .

  ## Start container services
  $docker-compose up -d

  ## Shutdown container services
  $docker-compose down
  ```
#### Sparkling Water Info:
- Documentation
  [https://s3.amazonaws.com/h2o-release/sparkling-water/spark-2.4/3.38.0.1-1-2.4/index.html](https://s3.amazonaws.com/h2o-release/sparkling-water/spark-2.4/3.38.0.1-1-2.4/index.html) <br/>

- Build Examples with Gradle:
  ```
  $gradle
  ```
