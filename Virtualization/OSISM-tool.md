## The OSISM tool

### osismclient
* All management happens on the manager node
    - Most of it by calling the osism command line tool
    - It's a wrapper to call the `osism` program in the `osismclient` container
        * except for `update manager` and `update docker`
* osism offers command line completion (with `<TAB>`) and help
    - e.g. `osism reconciler --help`
* `osism get versions manager` gives you information on your managed setup
* `osism log container HOST CONTAINER` will retrieve log files for you (`docker logs`)
* `osism manage XXX` is a wrapper for flavor and image manager


### OSISM playbooks
* `osism apply PLAYBOOK` runs ansible playbooks with the appropriate settings
    - `osism apply -a stop PLAYBOOK` would typically stop the service referenced by `PLAYBOOK`
    - `osism apply -a upgrade PLAYBOOK` would get the latest version of a service (container) and then
      run the `PLAYBOOK` to start the service referenced by it
* `osism apply` gives you a list of PLAYBOOKS
* Running playbooks to start services that already run is harmless
    - Changed settings will be applied if there are
    - The playbook summary allows you to see whether that is the case (`changed=`)
* `osism get facts/hosts/hostvars/tasks/...` also just wraps ansible

### Performing changes workflow
* Perform changes in the checked out configuration repository ON A TEST OR REFERENCE ENVIRONMENT
    - Typically you end up editing some file under `/opt/configuration/environments/`
    - Push the changes (for your test environment) and apply them:
```bash
osism apply configuration   # Pull config from git
osism reconciler sync       # Adjust derived config files
osism apply facts           # Gather/Update ansible facts
```
    - Run the playbooks that consume the new settings: `osism apply PLAYBOOK`
    - If everything works as designed, commit the same changes to the config repository
      of your production environment.
        * Ensure review and approval processes are in place for this; some changes may
          require customer communication or approval from your security team
        * Same procedure: push to repo and use the above osism commands
* Read recommendations how to work with git branches
  <https://docs.scs.community/docs/iaas/guides/configuration-guide/manager#working-with-git-branches>
* Review is good, testing is better
    - Take reviews seriously!
        * Be mindful of hierarchies or cultural habits that e.g. prevent questioning higher ranked people
        * Think a moment about AF447 or Fukushima

