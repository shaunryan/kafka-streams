version := "1.0"

ThisBuild / scalaVersion := "2.13.3"


// https://mvnrepository.com/artifact/org.apache.kafka/kafka-streams-scala
libraryDependencies += "org.apache.kafka" %% "kafka-streams-scala" % "2.6.0"
// https://mvnrepository.com/artifact/org.apache.kafka/kafka-streams-test-utils
libraryDependencies += "org.apache.kafka" % "kafka-streams-test-utils" % "2.6.0" % Test
// https://mvnrepository.com/artifact/org.scalatest/scalatest
libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.1" % Test
