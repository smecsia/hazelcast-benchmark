require 'jrmvnrunner'
Jrmvnrunner.init!

java_import 'com.hazelcast.config.Config'
java_import 'com.hazelcast.core.Hazelcast'
java_import 'com.hazelcast.core.HazelcastInstance'
java_import 'com.hazelcast.core.Partition'
java_import 'com.hazelcast.core.PartitionService'
java_import 'java.util.concurrent.TimeUnit'

module HZ
  class Node
    attr_reader :hz, :config, :map_config

    def initialize
      @config = Config.new
      #@config.network_config.join.multicast_config.setEnabled(false)
      @config.setProperty("hazelcast.max.no.heartbeat.seconds", '5')
      @map_config = com.hazelcast.config.MapConfig.new
      @map_config.setName "default"
      @map_config.setAsyncBackupCount(3)
      @map_config.setReadBackupData(true)
      @config.addMapConfig(@map_config)
      @hz = Hazelcast.new_hazelcast_instance(@config)


    end

    def map(name)
      @hz.get_map(name)
    end
  end
end
