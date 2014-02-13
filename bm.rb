require 'node'
require 'benchmark'
require 'uuid'

class BM
  attr_reader :map, :node

  def initialize
    @node = HZ::Node.new
    @map = @node.map("benchmark")
  end

  def remote_keys
    @map.keySet.to_a - @map.localKeySet.to_a
  end

  def start!(size= 100, times = 50)
    uuid = UUID.new
    size.times { |n|
      @map.put(uuid.generate, object)
    }
    puts "Remote keys size: #{remote_keys.size}"
    remote_key = remote_keys.sample
    Benchmark.bm (7) do |x|
      x.report("map.keySet") {
        times.times { @map.keySet }
      }
      x.report("map.localKeySet") {
        times.times { @map.localKeySet }
      }
      x.report("map.get") {
        times.times { @map.get(remote_key) }
      }
      x.report("map.put") {
        times.times { @map.put(remote_key, object) }
      }
      x.report("map.lock/.unlock") {
        times.times { @map.lock(remote_key); @map.unlock(remote_key) }
      }
    end
  end

  private

  def object
    java.util.HashMap.new(UUID.new.generate.to_s => UUID.new.generate.to_s)
  end
end