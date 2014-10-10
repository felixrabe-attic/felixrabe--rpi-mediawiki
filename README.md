# MediaWiki installation for Raspberry Pi

    docker run --name mediawiki -d -p 80:80 felixrabe/rpi-mediawiki
    docker logs -f mediawiki

https://registry.hub.docker.com/u/felixrabe/rpi-mediawiki/

https://github.com/felixrabe/rpi-mediawiki

This installation works, but make sure you do not expose any public ports to
the Internet because of the security issues listed below. Feel free to
contribute by creating issues and PRs on GitHub.


## WARNING: Security issues (and other issues) I know of in the current version

-   First of all, I'm totally new to MediaWiki, so I might even have missed
    the biggest point here. Please open issues on GitHub for anything I've
    missed.

-   Your data is not completely safe in this setup, as it gets stored right
    inside the container together with the application itself. This should be
    improved using a [shared volume with a data
    container](https://docs.docker.com/userguide/dockervolumes/), so that data
    backups and application updates can happen more easily.

-   No automated build. I don't think there is a way yet to create an
    automated build for ARM images on the Docker Registry without
    cross-compilation hackery, but if there is, please let me know via a GitHub
    issue.

-   wgUpgradeKey is set to the static value as published on GitHub. Please
    change your LocalSettings.php to something else.

-   MySQL has no root password set.

-   There might be things (Apache, MySQL) running as root that should not. No
    effort was expended on user account setup.


## How this image was created

Basically, start the container using

    docker run --rm -ti felixrabe/rpi-mediawiki /bin/bash

then run

    mv /etc/mediawiki/LocalSettings.php{,-bak}
    /start.sh setup
    # Follow the instructions at the end. And then:
    gzip bootstrap.sql

and finally

    docker build -t felixrabe/rpi-mediawiki:nn-xxxxxxx .
    # 'nn' is a sequential "version" number, 'xxxxxxx' is the Git commit.
    docker tag felixrabe/rpi-mediawiki:nn-xxxxxxx felixrabe/rpi-mediawiki:latest


## License

This license covers this file README.md and the accompanying files, not the
software (Raspbian, Apache, MySQL, MediaWiki) that gets installed through
them.

The MIT License (MIT).

Copyright (c) 2014 Felix Rabe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
