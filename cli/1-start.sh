

# start zoo keeper
# zookeeper-server-start.sh $KAFKA_CONF/zookeeper.properties
zookeeper-server-start.sh $ZOOKEEPER_CONF/zoo.cfg

# start kafka
kafka-server-start.sh $KAFKA_CONF/server.properties
