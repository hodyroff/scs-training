## Internal infrastructure

OpenStack requires queuing and a database to work
* We use mariadb (free version of MySQL)
    - Clustered with galera for high availability
* memcached and/or proxysql for caching (performance)
* Queuing connects publishers and consumers of messages
    * which should be processed in order (FIFO)
    * OpenStack traditionally uses [rabbitmq](https://www.rabbitmq.com/docs/queues) as queuing (AMQP) service
    * We learned to prefer Quorum queues where possible

* OSISM comes with significantly more infrastructure
    * Monitoring
    * Lifecycle management
    * Log aggregation and search
    * k3s Cluster (for extensibility)


