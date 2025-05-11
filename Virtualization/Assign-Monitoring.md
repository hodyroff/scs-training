## Assignments Monitoring and Compliance

### Compliance tests
* Run a single test against a test environment
    - Use our CiaB setup if you have no access to your own
* Run the complete compliance suite
    - Rerun it with high verbosity (debugging) enabled
* Find the compliance status of the tested SCS clouds on the public SCS web pages

### OpenStack Health Monitor (30')
* Do this in pairs: Setup the OSHM
    - Find relevant docs page
    - Driver VM via GUI or by following instructions
    - Configure clouds.yaml ... and run a single iteration
    - Setup telegraf, influxdb, grafana
    - Bonus: Do the tmux autostart magic
    - Bonus2: Setup caddy for TLS/SSL access with LE certificate
