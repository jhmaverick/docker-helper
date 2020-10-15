# Docker Helper

### Global installation:
```shell script
sudo curl -L "https://raw.githubusercontent.com/jhmaverick/docker-helper/master/docker-helper" -o /usr/local/bin/docker-helper
sudo chmod +x /usr/local/bin/docker-helper
```

Ex: `docker-helper <cmd>`


### Install in a project:

```shell script
curl -L "https://raw.githubusercontent.com/jhmaverick/docker-helper/master/docker-helper" -o ./docker-helper
chmod +x ./docker-helper
```

Ex: `bash docker-helper <cmd>` or `./docker-helper <cmd>`

## Docker Helper File

Create the `docker-helper.yml` in the same directory as `docker-compose.yml`.

```yaml
variables:
  DOCKER_ENV: production
  SERVER_HOST: localhost
  SERVER_PORT: 8080

scripts:
  prod: "docker-compose up -d"
  dev: "docker-compose up --force-recreate"
  recreate: "docker-compose rm -sf && docker-compose up -d"
  update: "docker-compose pull && docker-helper recreate"
  force-remove: "docker-compose rm -sf"

hooks:
  init: "mkdir -p $PROJECT_ROOT/hook-test/test1"
```

## Environment

If "DOCKER_ENV" is defined in the .env file or docker-helper.yml, the "docker-compose.<DOCKER_ENV>.yml" 
and ".env.<DOCKER_ENV>" will be loaded automatically if they exist.


## Variables

- **PROJECT_ROOT:** Full path to docker-compose.yml.
- **PROJECT_NAME:** Basename of the project root.
- **USER_ID:** Current user ID.
- **GROUP_ID:** Current user group ID.
- **DOCKER_GROUP_ID:** Docker group ID.


## Scripts

Scripts can be created in the "scripts" index in docker-helper.yml or in the "docker-helper.d/scripts/" directory.

You can run a command using a service by running "<service_name>-exec".
The container will be created without dependencies and using the "project_root" as a volume keeping the current directory. The container will be removed after execution.

Ex: `./docker-helper nginx-exec /usr/sbin/nginx -v`


## Hooks

Hooks can be created in the "hooks" index in docker-helper.yml or in the "docker-helper.d/hooks/" directory.

- **init**
- **pre_commands**
- **pre_command_<name>**
- **post_command_<name>**
- **post_commands**
- **pre_compose**
- **post_compose**

