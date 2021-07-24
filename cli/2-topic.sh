


# kafka topics

# deprecated
kafka-topics --zookeeper 127.0.0.1:2181

# or kafka 2.2 +
kafka-topics.sh /
    --bootstrap-server 127.0.0.1:2181 /
    --topic first_topic --create /
    --partitions 3 /
    --replication-factor 1 # can't be greater than the number of topics we have.

# list the topics
kafka-topics.sh /
    --bootstrap-server 127.0.0.1:2181 --list

# where are they?
kafka-topics.sh /
    --bootstrap-server 127.0.0.1:2181 
    --topic first_topic --describe

# mark the tpoic for deletion - it will delete because delete.topic.enable=true by default
kafka-topics.sh /
    --bootstrap-server 127.0.0.1:2181 
    --topic first_topic --delete




