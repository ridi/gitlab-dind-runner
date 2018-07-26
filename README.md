# gitlab-dind-runner
GitLab CI runner on Docker in Docker environment  
Inspired by https://medium.com/@tonywooster/docker-in-docker-in-gitlab-runners-220caeb708ca

## Usage
```bash
# Create Docker containers
bin/service.sh start

# Register runner to GitLab CI server
bin/register_runner.sh https://gitlab.ridi.io/ RegiSTeRTokeN runner_name

# Unregister runner
bin/unregister_runner.sh RUnNErtokEN

# Remove Docker containers
bin/service.sh stop
```
