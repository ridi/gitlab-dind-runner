# gitlab-dind-runner
GitLab CI runner on Docker in Docker environment  
Inspired by https://medium.com/@tonywooster/docker-in-docker-in-gitlab-runners-220caeb708ca

## Usage
```bash
# Run service
bin/service.sh start

# Register to GitLab CI server
bin/runner/register.sh runner_name https://gitlab.ridi.io/ RegiSTeRTokeN
# Unregister
bin/runner/unregister.sh runner_name

# Clean unused Docker resources
bin/docker/prune.sh container
bin/docker/prune.sh volume
bin/docker/prune.sh image
bin/docker/prune.sh network

# Stop service
bin/service.sh stop
```
