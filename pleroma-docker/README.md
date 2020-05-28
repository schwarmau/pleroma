# Instance Description

This is the cyborg.cafe pleroma instance.

Information, Rules, ToS, and more can be found in [meta.d](/hosted/pleroma/src/branch/master/meta.d).

Visit https://pleroma.social to learn more about pleroma.

Visit https://memleak.eu/sn0w/pleroma-docker if you want to host your own instance.

This instance heavily utilizes the template for cofe.rocks.

# Pleroma-Docker (Unofficial) Readme

[Pleroma](https://pleroma.social/) is a selfhosted social network that uses OStatus/ActivityPub.

This repository dockerizes it for easier deployment.

<hr>

```cpp
#include <LICENSE>

/*
 * This repository comes with ABSOLUTELY NO WARRANTY
 *
 * I will happily help you with issues related to this script,
 * but I am not responsible for burning servers, angry users, fedi drama,
 * thermonuclear war, or you getting fired because your boss saw your NSFW posts.
 *
 * Please do some research if you have any concerns about the
 * included features or software ***before*** using it.
 *
 */
```

<hr>

## In the Wild

My own instance is managed by this script.
Take a look at [hosted/pleroma](/hosted/pleroma) if you get stuck or need some inspiration.

Does your instance use pleroma-docker?
Let me know and I'll add you to this list.

## Docs

These docs assume that you have at least a basic understanding
of the pleroma installation process and common docker commands.

If you have questions about Pleroma head over to https://docs.pleroma.social/.
For help with docker check out https://docs.docker.com/.

For other problems related to this script, contact me or open an issue :)

### Prerequisites

- ~1GB of free HDD space
- `git` if you want smart build caches
- `curl`, `jq`, and `dialog` if you want to use `./pleroma.sh mod`
- Bash 4+
- Docker 18.06+ and docker-compose 1.22+

### Installation

- Clone this repository
- Create a `config.exs` and `.env` file
- Run `./pleroma.sh build` and `./pleroma.sh up`
- [Configure a reverse-proxy](#my-instance-is-up-how-do-i-reach-it)
- Profit!

Hint:
You can also use normal `docker-compose` commands to maintain your setup.
The only command that you cannot use is `docker-compose build` due to build caching.

### Configuration

All the pleroma options that you usually put into your `*.secret.exs` now go into `config.exs`.

`.env` stores config values that need to be known at orchestration/build time.
Documentation for the possible values is inside of that file.

### Updates

Run `./pleroma.sh build` again and start the updated image with `./pleroma.sh up`.
You don't need to stop your pleroma server for either of those commands.

### Maintenance

Pleroma maintenance is usually done with mix tasks.
You can run these tasks in your running pleroma server using `./pleroma.sh mix [task] [arguments...]`.
For example: `./pleroma.sh mix pleroma.user new sn0w ...`
If you need to fix bigger problems you can also spawn a shell with `./pleroma.sh enter`.

### Customization

Add your customizations (and their folder structure) to `custom.d/`.
They will be copied into the right place when the container starts.
You can even replace/patch pleroma’s code with this,
because the project is recompiled at startup if needed.

In general: Prepending `custom.d/` to pleroma’s customization guides should work all the time.
Check them out in the [pleroma documentation](https://docs.pleroma.social/small_customizations.html#content).

For example: A custom thumbnail now goes into `custom.d/` + `priv/static/instance/thumbnail.jpeg`.

### Patches

Works exactly like customization, but we have a neat little helper here.
Use `./pleroma.sh mod [regex]` to mod any file that ships with pleroma, without having to type the complete path.

### My instance is up, how do I reach it?

To reach Gopher or SSH, just uncomment the port-forward in your `docker-compose.yml`.

To reach HTTP you will have to configure a "reverse-proxy".
Older versions of this project contained a huge amount of scripting to support all kinds of reverse-proxy setups.
This newer version tries to focus only on providing good pleroma tooling.
That makes the whole process a bit more manual, but also more flexible.

You can use Caddy, Traefik, Apache, nginx, or whatever else you come up with.
Just modify your `docker-compose.yml` accordingly.

One example would be to add an [nginx server](https://hub.docker.com/_/nginx) to your `docker-compose.yml`:
```yml
  # ...

  proxy:
    image: nginx
    init: true
    restart: unless-stopped
    links:
      - server
    volumes:
      - ./my-nginx-config.conf:/etc/nginx/nginx.conf:ro
    ports:
      - "80:80"
      - "443:443"
```

Then take a look at [the pleroma nginx example](https://git.pleroma.social/pleroma/pleroma/blob/develop/installation/pleroma.nginx) for hints about what to put into `my-nginx-config.conf`.

Using apache would work in a very similar way (see [Apache Docker Docs](https://hub.docker.com/_/httpd) and [the pleroma apache example](https://git.pleroma.social/pleroma/pleroma/blob/develop/installation/pleroma-apache.conf)).

The target that you proxy to is called `http://server:4000/`.
This will work automagically when the proxy also lives inside of docker.

If you need help with this, or if you think that this needs more documentation, please let me know.

Something that cofe.rocks uses is simple port-forwarding of the `server` container to the host's `127.0.0.1`.
From there on, the natively installed nginx server acts as a proxy to the open internet.
You can take a look at cofe's [compose yaml](/hosted/pleroma/src/branch/master/docker-compose.yml) and [proxy config](/hosted/pleroma/src/branch/master/proxy.xconf) if that setup sounds interesting.

### Attribution

Thanks to [Angristan](https://github.com/Angristan/dockerfiles/tree/master/pleroma) and [RX14](https://github.com/RX14/kurisu.rx14.co.uk/blob/master/services/iscute.moe/pleroma/Dockerfile) for their dockerfiles, which served as an inspiration for the early versions of this script.

The current version is based on the [offical install instructions](https://docs.pleroma.social/alpine_linux_en.html).
Thanks to all people who contributed to those.
