# Use for CashNotify

## Update Nov. 2017

THIS IS NOT USED ANYMORE WITH CASHNOTIFY SINCE WE USE SENTRY TO REPORT EXCEPTIONS.

## Deploy

- https://crash.cashnotify.com: Crash reporting server. Uses [mini-breakpad-server](https://github.com/julienma/mini-breakpad-server). Hosted on Devbox. SSL through LetsEncrypt.

```bash
dokku config:set crash.cashnotify.com DOKKU_PROXY_PORT_MAP="http:80:1127 https:443:1127"

# setup HTTP Basic Auth
dokku config:set crash.cashnotify.com HTTP_AUTH_USERNAME=cashnotify HTTP_AUTH_PASSWORD=aVeryLongPasswordStoredIn1P

# create persistent storage volume to store crash dumps
sudo mkdir -p /var/www/crash.cashnotify.com/pool
sudo chown dokku:dokku -R /var/www/crash.cashnotify.com
dokku storage:mount crash.cashnotify.com /var/www/crash.cashnotify.com/pool/:/app/pool

# if there's a "DOCKER_OPTIONS_DEPLOY: Permission denied" error: chown and retry "dokku storage:mount ..."
sudo chown dokku:dokku /home/dokku/crash.cashnotify.com/DOCKER_OPTIONS_DEPLOY
```

# mini-breakpad-server

Minimum collecting server for crash reports sent by
[google-breakpad](https://code.google.com/p/google-breakpad/).


## Features

* No requirement for setting up databases or web servers.
* Collecting crash reports with minidump files.
* Simple web interface for viewing translated crash reports.

## Run

* `npm install .`
* `grunt`
* Put your breakpad symbols under `pool/symbols/PRODUCT_NAME`
* `node lib/app.js`
