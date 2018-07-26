# gitlab-dind-runner

## Usage
```bash
# Create Docker containers
bin/service.sh start

# Register runner to GitLab CI server
bin/register_runner.sh https://gitlab.ridi.io/ RegiSTeRTokeN runner_name

# Unregister runner
bin/unregister_runner.sh RegiSTeRTokeN

# Remove Docker containers
bin/service.sh stop
```
