Wetty = Web + tty
-----------------

Terminal over HTTP and HTTPS. Wetty is an alternative to
ajaxterm/anyterm but much better than them because wetty uses ChromeOS'
terminal emulator (hterm) which is a full fledged implementation of
terminal emulation written entirely in Javascript. Also it uses
websockets instead of Ajax and hence better response time.

hterm source - https://chromium.googlesource.com/apps/libapps/+/master/hterm/

![Wetty](/terminal.png?raw=true)

Install
-------

*  `git clone https://github.com/krishnasrinivas/wetty`

*  `cd wetty`

*  `npm install`

Run on HTTP:
-----------

    node app.js -p 3000

If you run it as root it will launch `/bin/login` (where you can specify
the user name), else it will launch `ssh` and connect by default to
`localhost`.

If instead you wish to connect to a remote host you can specify the
`--sshhost` option, the SSH port using the `--sshport` option and the
SSH user using the `--sshuser` option.

You can also specify the SSH user name in the address bar like this:

  `http://yourserver:3000/wetty/ssh/<username>`

Run on HTTPS:
------------

Always use HTTPS! If you don't have SSL certificates from a CA you can
create a self signed certificate using this command:

  `openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 30000 -nodes`

And then run:

    node app.js --sslkey key.pem --sslcert cert.pem -p 3000

Again, if you run it as root it will launch `/bin/login`, else it will
launch SSH to `localhost` or a specified host as explained above.

Run wetty behind nginx:
----------------------

Put the following configuration in nginx's conf:

    location /wetty {
	    proxy_pass http://127.0.0.1:3000/wetty;
	    proxy_http_version 1.1;
	    proxy_set_header Upgrade $http_upgrade;
	    proxy_set_header Connection "upgrade";
	    proxy_read_timeout 43200000;

	    proxy_set_header X-Real-IP $remote_addr;
	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	    proxy_set_header Host $http_host;
	    proxy_set_header X-NginX-Proxy true;
    }

If you are running `app.js` as `root` and have an Nginx proxy you have to use:

    http://yourserver.com/wetty

Else if you are running `app.js` as a regular user you have to use:

    http://yourserver.com/wetty/ssh/<username>

**Note that if your Nginx is configured for HTTPS you should run wetty without SSL.**

Issues
------

Does not work on Firefox as hterm was written for ChromeOS. So works well on Chrome.
