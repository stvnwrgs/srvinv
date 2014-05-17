srvinv
==========

a server inventory

What is this?
==========
It is a very simple configuration management database. It has three resources
to store machine configurations:

- env: environments (e.g. used for datacenter organization)
- net: networks (very, very simple)
- srv: servers

These resources come with default keys. However they can be extended to your
liking by simply updating the resource. For example, the srv resource has a
key called os_arch. If you need another os key on a srv you can simply push it
to os_whateveryouneed and it will be saved.

Requirements
==========
This repo includes the daemon that serves a REST api and saves data into a given
mongodb. You need to be able to run:

- ruby 1.9.3
- bundler
- mongodb (tested with 2.6.1)

Installation
==========
Please follow these steps to install the srvinv daemon to a machine. A basic setup
means having the daemon on the same machine as the mongodb. For production environments
this is highly discouraged! In those cases you want to split up the db to another
machine and you might also want create a load balanced pool of api machines.

- Install ruby 1.9.3 (preferable using rbenv)
- Install mongodb
- Clone this repo to your machine
- Configure the daemon through include/config.rb
- Install bundler
- Run 'bundle install' to install needed ruby gems
- Run 'unicorn'

You should be able to access the api at http://yourmachine:8080 now.

Please be aware: The api does not support auth for now. Any machine capable of
http requests is potentially able to ruin your day. Do not assign public
ip addresses to your machine serving the api!

You should also proxy any request through an nginx to the unicorn server. This
way you can add simple auth methods or other features (like loadbalancing or
caching).

Usage
==========
Please see srvinv-cli on https://github.com/brtz/srvinv-cli for how to access
the inventory.

Hooks
==========
This is a neat little feature: Basically a hook is called once an update request
was done by the daemon. E.g. If you are saving your CNAME for a machine inside
srvinv and update that CNAME a hook can be used to notify your dns servers to update
the zones.

Hooks are ruby classes implementing the include/hook.rb interface. They have to
be stored inside the hooks directory.
Please have a look at examples/dummy.rb.

Todo
==========
- more config options
- MAYBE auth

License
==========
Please see the LICENSE file.
