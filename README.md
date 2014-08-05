Fett
======

Fett talks with [GitHub](https://github.com), [Slack](https://slack.com) and [Jenkins](https://jenkins.com) to give you all the information about your builds right in your chat room.

Installing
----------

* Fett requires [Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins), I'm using the 1.574 version but it works on 1.427 too. The [Notification Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin) is required in order to tell Fett about how last build went.
* I've only tested Fett on [Ruby](https://www.ruby-lang.org/es/) 2.1.0. It may work on older versions, but I haven't tested it. Anyways, if you give Fett a shot and get it working in any other version, give me a shout.

Install the dependencies:

```bash
$ bundle install --binstubs
```

Run the server:

```bash
$ bundle exec rackup -o 0.0.0.0
```

Done :)

Configuring
-----------

Fett makes heavy use of environment variables (all of them required):

* `FETT_URL`: The URL where Fett will listen. Eg: https://fett.example.com

* `FETT_GITHUB_LOGIN`: Any GitHub with access to your repos. Fett will use it to talk to the GitHub API. Eg: pedrogimenez
* `FETT_GITHUB_PASSWORD`: The password for the previous GitHub login. Eg: yolo


* `FETT_JENKINS_URL`: The URL where Jenkins is hidden. Eg: https://jenkins.example.com
* `FETT_JENKINS_USERNAME`: HTTP Basic Auth user. Eg: pedrogimenez
* `FETT_JENKINS_PASSWORD`: HTTP Basic Auth password. Eg: yolo


* `FETT_SLACK_URL`: Your Slack webhook URL. Eg: https://example.slack.com/services/hooks/incoming-webhook?token=xxxx


* `FETT_REDIS_HOST`: The host where Redis is installed. Eg: 127.0.0.1
* `FETT_REDIS_PORT`: The port where Redis will be listening. Eg: 6379
* `FETT_REDIS_PASSWORD`: Redis Auth Password. Eg: yolo
* `FETT_REDIS_DATABASE`: Redis database. Eg: 1

Hacking
-------

Install the dependencies:

```bash
$ bundle install --binstubs
```

You need to setup the environment variables related to Redis before running the tests:

* `FETT_REDIS_HOST`
* `FETT_REDIS_PORT`
* `FETT_REDIS_PASSWORD`
* `FETT_REDIS_DATABASE`

Run the tests:

```bash
$ script/cibuild
```

Run the server:

```bash
$ bundle exec rackup -o 0.0.0.0
```

Done :)

Contributing
------------

Just fork the repo and send a PR <3
