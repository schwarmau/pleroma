# pleroma
Fork of pleroma and pleroma-fe (https://pleroma.social/)

```
git init
git remote add origin https://github.com/schwarmau/pleroma.git
git checkout origin/master
cd pleroma
git init
git remote add origin https://git.pleroma.social/pleroma/pleroma.git
git fetch
git checkout origin/stable
cd ../pleroma-fe
git init
git remote add origin https://git.pleroma.social/pleroma/pleroma-fe.git
git fetch
git checkout origin/master
cd ..
```

TODO List:

Add dockerfile

Notes:
- `docker build [project directory] -f [dockerfile location\Dockerfile] -t [name your image] --build-arg [variable name]=[value]`
    - use `--rm=false --no-cache` options to not remove intermediary containers made
    - use `--build-arg` as many times as needed
- `docker create -it -p [host-machine-port-no]:[container-port-no] -v --name [your image name]:[your image tag]`
- get name/tag with `docker images`
- `docker container start [container id]`
- get container id with `docker container ls` or `docker container ls -a`
- use `docker container start [container id] -i` to get logging upon starting the container
- `docker run -it [image name]:[image tag] sh` to temporarily run a container with an interactive shell
- `docker exec -it [container id] /bin/bash` to get a bash shell into a running container