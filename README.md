# Web Framework Benchmarks
Multiple implementations of a same website using various frameworks. Benchmarked with wrk.

## Platform Information
|                     CPU                      |    RAM     |     OS     |
|:--------------------------------------------:|:----------:|:----------:|
| AMD Ryzen 7 5800X (8C16T, 2.2 GHz ~ 4.8 GHz) | 16 GB DDR4 | Arch Linux |

## Database
MySQL 8.2.0

## Setup Notes
To provide isolation between different components, MySQL was run on core 0 to 3 and the wrk was run on core 14 using ```taskset```.
All projects also disabled the static file functionality during benchmarking.

## Conclusion
![Chart](/img/chart.svg)

## Todo
- Redo PHP benchmarks when PHP 8.3.0 is released, use TCP for php-fpm
- Redo Ruby on Rails benchmark when ruby 3.2.0 is released

## Sponsor
It takes a lot of time to create and maintain a project.  If you think it helped you, could you buy me a cup of coffee? 😉  
You can use any of the following methods to donate:

| [![PayPal](/img/paypal.svg)](https://www.paypal.com/paypalme/tianchentang)<br/>Click [here](https://www.paypal.com/paypalme/tianchentang) to donate | ![Wechat Pay](/img/wechat.jpg)<br/>Wechat Pay | ![Alipay](/img/alipay.jpg) Alipay |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|-----------------------------------|

## PHP
### Software Stack
|  PHP   | Framework |    Server    | Template Engine | Database Driver |
|:------:|:---------:|:------------:|:---------------:|:---------------:|
| 8.2.12 |    PHP    | NGINX 1.25.3 |       PHP       |    PDO MySQL    |

### Deployment Notes
NGINX are configured to use exactly four worker processes and was run on core 8 to 11.  
PHP-FPM are configured to use exactly four child processes and was run on core 4 to 7.

### WRK Statistics
```
[root@localhost]# systemctl restart mysqld nginx && echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM php-fpm
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.24ms   15.44ms 173.74ms   95.62%
    Req/Sec     7.52k     1.27k    9.01k    61.46%
  225226 requests in 30.10s, 3.80GB read
Requests/sec:   7482.71
Transfer/sec:    129.18MB
```

### Perf Statistics
```
[root@localhost]# perf stat -e cycles taskset -c 4-7 php-fpm --nodaemonize
 Performance counter stats for 'taskset -c 4-7 php-fpm --nodaemonize':

      335907578771      cycles                                                                

      34.594002484 seconds time elapsed

      29.848465000 seconds user
      39.696707000 seconds sys
```

## Swoole
### Software Stack
|  PHP   |  Framework   | Template Engine | Database Driver |
|:------:|:------------:|:---------------:|:---------------:|
| 8.2.12 | Swoole 5.1.1 |       PHP       |    PDO MySQL    |

### Deployment Notes
NGINX are configured to use exactly four worker processes and was run on core 8 to 11.  
PHP-FPM are configured to use exactly four child processes and was run on core 4 to 7.

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM php
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.68ms  420.12us  26.01ms   97.99%
    Req/Sec     3.71k   138.73     3.98k    70.76%
  111217 requests in 30.10s, 1.86GB read
Requests/sec:   3694.97
Transfer/sec:     63.25MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 php ./server.php
 Performance counter stats for 'taskset -c 4-7 php ./server.php':

      180770614917      cycles                                                                

      32.231153355 seconds time elapsed

      19.572653000 seconds user
      19.320056000 seconds sys
```

## Laravel
### Software Stack
|  PHP   |       Framework       |    Server    | Template Engine | Database Driver |
|:------:|:---------------------:|:------------:|:---------------:|:---------------:|
| 8.2.12 |    Laravel 10.32.1    | NGINX 1.25.3 |      Blade      |  Eloquent ORM   |

### Deploy Steps
./deploy.sh

### Deployment Notes
NGINX are configured to use exactly four worker processes and was run on core 8 to 11.  
PHP-FPM are configured to use exactly four child processes and was run on core 4 to 7.

### WRK Statistics
```
[root@localhost]# systemctl restart mysqld nginx && echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM php-fpm
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   110.62ms   10.94ms 193.35ms   64.95%
    Req/Sec    90.44      9.29   121.00     40.13%
  2705 requests in 30.01s, 92.28MB read
Requests/sec:     90.13
Transfer/sec:      3.07MB
```

### Perf Statistics
```
[root@localhost]# perf stat -e cycles taskset -c 4-7 php-fpm --nodaemonize
 Performance counter stats for 'taskset -c 4-7 php-fpm --nodaemonize':

      547552840985      cycles                                                                

      34.949713474 seconds time elapsed

     113.126389000 seconds user
       4.976391000 seconds sys
```

## Ruby on Rails
### Software Stack
| Ruby  |  Framework  |   Server   | Template Engine |      Database Driver       |
|:-----:|:-----------:|:----------:|:---------------:|:--------------------------:|
| 3.0.6 | Rails 7.1.2 | Puma 6.4.0 |       ERB       | Active Records with mysql2 |

### Deployment Notes
Delete ```config/credentials.yml.enc``` and ```config/master.key``` and run ```EDITOR=vim rails credentials:edit```. We need to terminate puma server manually.

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080
pid 1386's current affinity list: 12-15
pid 1386's new affinity list: 12-15
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    19.59ms   18.41ms 156.46ms   89.94%
    Req/Sec   594.57     82.78   787.00     71.00%
  17757 requests in 30.01s, 798.10MB read
Requests/sec:    591.70
Transfer/sec:     26.59MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 bin/rails server -e production -b 127.0.0.1 -p 8080
 Performance counter stats for 'taskset -c 4-7 bin/rails server -e production -b 127.0.0.1 -p 8080':

      555549893125      cycles                                                                

      36.856537051 seconds time elapsed

     115.892619000 seconds user
       4.037542000 seconds sys
```

## Django
### Software Stack
| Python |  Framework   |              Server              | Template Engine |   Database Driver    |
|:------:|:------------:|:--------------------------------:|:---------------:|:--------------------:|
| 3.11.5 | Django 4.2.7 | gunicorn 20.1.0 + uvicorn 0.24.0 |     Django      | ORM with mysqlclient |

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM gunicorn
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    32.39ms   28.90ms 161.50ms   81.02%
    Req/Sec   372.25     69.48   550.00     69.67%
  11122 requests in 30.01s, 250.77MB read
Requests/sec:    370.56
Transfer/sec:      8.36MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 gunicorn --worker-class uvicorn.workers.UvicornWorker --workers 4 --bind 127.0.0.1:8080 wbm.asgi:application
 Performance counter stats for 'taskset -c 4-7 gunicorn --worker-class uvicorn.workers.UvicornWorker --workers 4 --bind 127.0.0.1:8080 wbm.asgi:application':

      486712197895      cycles                                                                

      36.053177294 seconds time elapsed

      96.568699000 seconds user
       9.186791000 seconds sys
```

## Node.js
### Software Stack
| Node.js |   Framework    | Template Engine | Database Driver |
|:-------:|:--------------:|:---------------:|:---------------:|
| v17.6.0 | express 4.18.2 |   eta 1.14.2    |  mysql2 2.3.3   |

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM node
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.42ms    1.27ms  53.03ms   92.45%
    Req/Sec     2.27k   187.89     2.46k    88.67%
  67738 requests in 30.00s, 2.06GB read
Requests/sec:   2257.90
Transfer/sec:     70.31MB
```

### Perf Statistics
```
 Performance counter stats for 'taskset -c 4-7 node index.js':

      150410878773      cycles                                                                

      33.707049203 seconds time elapsed

      28.963500000 seconds user
       2.153001000 seconds sys
```

## Go
### Software Stack
|   Go   | Template Engine |   Database Driver   |
|:------:|:---------------:|:-------------------:|
| 1.21.4 |  html/template  | go-sql-driver 1.7.1 |

### Build Steps
Build command: ```GOAMD64=v3 go build -v -trimpath -ldflags "-s -w -buildid="```

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM wbm
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.69ms    0.90ms  11.93ms   71.16%
    Req/Sec     5.88k   405.92     6.99k    66.11%
  176156 requests in 30.10s, 4.85GB read
Requests/sec:   5852.43
Transfer/sec:    165.13MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 ./wbm
 Performance counter stats for 'taskset -c 4-7 ./wbm':

      482714017050      cycles                                                                

      34.191427487 seconds time elapsed

      89.587188000 seconds user
      11.533201000 seconds sys
```

## Springboot
### Software Stack
|  Java  | Springboot | Template Engine |         Database Driver         |
|:------:|:----------:|:---------------:|:-------------------------------:|
| 1.21.4 |   3.2.0    |   FreeMarker    | Spring Data JPA with MySQL JDBC |

### Build Steps
Build command: ```./gradlew build```

### Build Notes
The build did not use virtual threads as it have problem of utilizing all the CPU power.

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM java
Running 30s test @ http://localhost:8080
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.04ms   19.70ms 357.94ms   99.00%
    Req/Sec     4.93k     2.03k    6.85k    78.52%
  146384 requests in 30.10s, 6.18GB read
Requests/sec:   4863.28
Transfer/sec:    210.12MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 java -jar wbm-1.0.0.jar
 Performance counter stats for 'taskset -c 4-7 java -jar wbm-1.0.0.jar':

      560840412094      cycles                                                                

      35.382206615 seconds time elapsed

     100.508730000 seconds user
      18.028035000 seconds sys
```

## ASP.NET Core
### Software Stack
| C# | ASP.NET | Template Engine |   Database Driver    |
|:--:|:-------:|:---------------:|:--------------------:|
| 11 |   8.0   |      Razor      | MySqlConnector 2.3.1 |

### Build Steps
The project was built in ["Framework-dependent executable"](https://docs.microsoft.com/en-us/dotnet/core/deploying/deploy-with-cli#framework-dependent-executable) mode.  
Build command: ```dotnet publish -c Release -r linux-x64```

### Deployment Notes
```aspnet-runtime``` need to be installed.

### WRK Statistics
```
[root@localhost]# echo 3 > /proc/sys/vm/drop_caches && echo 0 > parameters/index && taskset -cp 12-15 $$ && wrk -t 1 -d 30s -s request-query-parameters.lua http://localhost:8080 && killall -TERM wbm
Running 30s test @ http://localhost:5000
  1 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.28ms   28.36ms 583.51ms   98.82%
    Req/Sec     6.99k     2.23k    8.84k    81.14%
  206778 requests in 30.00s, 6.27GB read
Requests/sec:   6892.57
Transfer/sec:    213.96MB
```

### Perf Statistics
```
[root@localhost]# systemctl restart mysqld && perf stat -e cycles taskset -c 4-7 ./wbm
 Performance counter stats for 'taskset -c 4-7 ./wbm':

      502995680739      cycles                                                                

      33.235992079 seconds time elapsed

      96.155133000 seconds user
      12.186199000 seconds sys
```
