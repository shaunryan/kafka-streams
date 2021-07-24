package com.shaunryan.kafka.streams;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.*;
import org.apache.kafka.streams.kstream.*;

import java.util.Arrays;
import java.util.List;
import java.util.Properties;

public class FavouriteColour {

    public static void main(String[] args) {

        Properties config = new Properties();
        config.put(StreamsConfig.APPLICATION_ID_CONFIG, "streams.start.app");
        config.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        config.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        config.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());

        //disabled the cache to demonstrate all the steps involved in the transformation - not recommended in prod
        config.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, "0");

        final List<String> colours = Arrays.asList("green","blue","red");

        final StreamsBuilder builder = new StreamsBuilder();
        // get a stream from kafka
        builder.stream("favourite-colour-input", Consumed.with(Serdes.String(),Serdes.String()))
                .filter((k,v) -> v.contains(","))
                .selectKey((k,v) -> v.split(",")[0].toLowerCase())
                .mapValues(v -> v.split(",")[1].toLowerCase())
                .filter((k, v) -> colours.contains(v))
                .to("user-keys-and-colours");

        // we need it as a k-table so that updates are read correctly
        // we count the occurrences of colours
        builder.table("user-keys-and-colours", Consumed.with(Serdes.String(),Serdes.String()))
                .groupBy((user, colour) -> new KeyValue<>(colour, colour))
                .count(Named.as("CountsByColours"))
                .toStream().to("", Produced.with(Serdes.String(), Serdes.Long()));

        Topology topology = builder.build();

        final KafkaStreams streams = new KafkaStreams(topology, config);
        streams.start();

        System.out.println(streams.toString());

        // Attach shutdown handler to catch Control-C.
        Runtime.getRuntime().addShutdownHook(new Thread(streams::close));


    }

}
