# Jupyter Notebook Docker v0.1.0

Docker image intended for running a Jupyter notebook server locally.

## Requirements

This server requires Docker and docker-compose. All further dependencies are managed within the Dockerfile build script and don't need to be explicitly installed by a user.

## How to Use

To run the server:

```shell
docker-compose build server
docker-compose run --service-ports --rm server
```

The server should then be accessible at [http://localhost:8888](http://localhost:8888) or [http://0.0.0.0:8888](http://0.0.0.0:8888).

The server saves notebooks into `/app/notebooks` which maps to `./notebooks` locally. The notebooks dir is gitignored by default. To save the notebooks themselves either fork this repository and un-ignore the notebooks dir so the notebooks are tracked by git or back them up manually.

If additional requirements are needed add them to `requirements.txt` and run:

```shell
docker-compose build server
```

This will rebuild the image and install all dependencies listed in `requirements.txt`. If system-level dependencies are needed they will need to be installed in the `server.dockerfile` using the `yum` command and the image will also need to be rebuilt.

## Todo

- Add a CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
- Add section on `INSTALL_VIM_BINDINGS` Docker ARG
