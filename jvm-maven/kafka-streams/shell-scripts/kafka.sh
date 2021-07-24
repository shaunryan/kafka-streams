
# create the topics
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic word-count-input
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 2 --topic word-count-output

# run the consumer
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic word-count-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer

# run a producer
kafka-console-producer.sh --broker-list localhost:9092 --topic word-count-input

# list the topics we have
kafka-topics.sh --list --zookeeper localhost:2181

# build
cd /Users/shaunryan/learn/kafkastreams/jvm-maven/kafka-streams/word-count
mvn clean package

# run the stream
java -jar target/word-count-1.0-SNAPSHOT-jar-with-dependencies.jar