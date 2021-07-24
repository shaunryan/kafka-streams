
# creates a consumer however you won't see historical messages only new one's
kafka-console-consumer.sh \
    --bootstrap-server 127.0.0.1:9092 \
    --topic first_topic

# to read all of the topic
# they're not in order because there are 3 partitions
kafka-console-consumer.sh \
    --bootstrap-server 127.0.0.1:9092 \
    --topic first_topic \
    --from-beginnning

# creates a consumer in a group
kafka-console-consumer.sh \
    --bootstrap-server 127.0.0.1:9092 \
    --topic first_topic \
    --group my-third-application