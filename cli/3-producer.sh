

# create a producer and enter some data.
kafka-console-producer.sh /
    --broker-list 127.0.0.1:9092 /
    --topic first_topic

# set the ack level 0, 1, all
kafka-console-producer.sh \
    --broker-list 127.0.0.1:9092 \
    --topic first_topic \
    --producer-property acks=all


# producing to a topic that doesn't it exist so it creates!
# gives a warning because there is no leader but it recovers so it doesn't error
kafka-console-producer.sh /
    --broker-list 127.0.0.1:9092 /
    --topic new_tpoic /
    --producer-property acks=all


# new-topic has 1 partition and 1 replication - not great
# always create topics beforehand
kafka-topics.sh /
    --bootstrap-server 127.0.0.1:2181 
    --topic new_tpoic --describe


# to change defaults - log basics
code %KAFKA_CONF/server.properties

