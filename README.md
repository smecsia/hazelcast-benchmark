# Hazelcast Benchmark

This project allows to test the Hazelcast Distributed Map performance.
It shows the benefits of [localKeySet](http://hazelcast.googlecode.com/svn-history/r1068/javadoc/com/hazelcast/core/IMap.html#localKeySet%28%29) and
 [backup reads](http://www.hazelcast.org/docs/latest/manual/html-single/#MapBackup).

## How to launch

### 1. Clone this project
### 2. Install RVM:

```bash
\curl -L https://get.rvm.io | bash -s stable
. ~/.bashrc
```

If you are the Mac user, perhaps you will need to add theese lines into your .bashrc file manually:

```bash
if [[ -d "$HOME/.rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi
```

### 3. Install JRuby
```bash
rvm install jruby-1.7.4
rvm use jruby-1.7.4
```

### 4. Install jrmvnrunner
```bash
gem install jrmvnrunner
```
### 5. Slow down the local network
```bash
./slow-down-local-network start
```
### 6. Run first node of HZ
```bash
./run node
```
### 7. Run the benchmark with 20 keys in the map and 100 iterations
```bash
./run 20 100
```

That's it. You should see something like:
```bash
                    user        system      total        real
map.keySet          0.320000   0.010000   0.330000 (  4.205000)
map.localKeySet     0.010000   0.000000   0.010000 (  0.010000)
map.get             0.000000   0.000000   0.000000 (  0.003000)
map.put             0.140000   0.000000   0.140000 (  4.076000)
map.lock/.unlock    0.100000   0.020000   0.120000 (  8.390000)
```

### 8. Don't forget to disable the network slowing down:
```bash
./slow-down-local-network stop
```
