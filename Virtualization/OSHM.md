## OpenStack Health Monitor (OSHM)

### What it does
* OpenStack is a scenario test that was created ~9 years ago to simulate a
  customer deployment scenario that was claimed not t work correctly and
  attempted to reproduce the issue. The issue would only happen occasionally ...
    - Was written as bash script using openstack CLI
    - Runs many iterations to expose issue
* It has long outgrown its initial purpose
    - Lots of options to make deployemnt scenario more complex to trigger
      more exotic issues (that have been observed in real clouds though)
    - Records timing of commands and thus measures control plane performance
    - Has three minimal benchmarks (CPU, Net, Disk) to also record user performance
    - Data can be written to an influxdb (via telegraf) and visualized via grafana
    - Logic to clean up even in exotic error cases
* Unfortunately still a meanwhile overly complex shell script
    - Thus a successor project (using cucumber/gherkin) has been created which will
      in the future replace the old OSHM

### Setup
* It is a snowflake setup: Create a driver VM in which you run the script
    - Actually you can run this from any machine that supports bash and openstack CLI
    - But we prefer to run it in the same cloud
        * Tests continue when external connectivity breaks
        * Monitor external connectivity via a different way (trivial)
    - Ideally you have a second OpenStack project where the resources under
      test are created, tested, cleaned up.
* Driver VM then also runs telegraf, influxdb, grafana
    - Log files are stored in filesystem and are optionally pushed to Object Storage
    - Console output is optimized for readability (unlike log files), attach to it via `tmux attach`
    - Autostart realized via injecting keys into tmux ...
* Documentation at: <https://docs.scs.community/docs/operating-scs/guides/openstack-health-monitor/Debian12-Install>
    - Takes ~1hr to set up when doing for the first time

### Dashboard
* Looking at 1 or 2 day views to understand the current state of your cloud
    - Use 30d or 6m for long-time trends
    - You can zoom in with the mouse
* Describing what you view:
    - Above the panels: Selecting cloud and filtering per resource, per service, ...
    - First row: Gauges with errors and error rates
        * You should achieve 99.9% or better here
        * An occasional API error (2 per day or so) is not something to worry about
    - Second through fourth row: Errors
        * This is the timeline for various kinds of errors
        * Ideally, it's all zero
    - Fifth through seventh row: Performance
        * API performance, Resource wait times, Benchmark results
        * Resource waits: Some API calls (e.g. VM creation) return as soon as the parameters
          have been validated and the cloud start provisioning the resource. It can take
          some time which you want to monitor as well

### OSHM and SCS certification
* Our compliance dashboard currently links the OSHM dashboards
    - This is not a requirement for achieving *SCS-compatible* certification
    - It will be a requirement for the upcoming *SCS-sovereign* certification
* It's best practice to have it and even share with the SCS community
    - Making quality transparent improves quality ...
