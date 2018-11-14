# HyDe on Docker

```bash
# Pull the docker image
docker pull pblischak/hyde-docker

# Start running a container and link the folder
# with your data. Add your own path but don't 
# change the `/home` part.
docker run -it -v </path/to/data>:/home pblischak/hyde-docker
```