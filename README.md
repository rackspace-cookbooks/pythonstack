# pythonstack Cookbook
-------------------------------

Supported Platforms
-------------------
* Ubuntu 12.04
* Centos 6.5

Requirements
------------
#### Cookbooks

* `newrelic_meetme_plugin`
* `application_python`
* `rackspace_gluster`
* `build-essential`
* `platformstack`
* `application`
* `redis-multi`
* `mysql-multi`
* `chef-sugar`
* `memcached`
* `database`
* `newrelic`
* `pg-multi`
* `rabbitmq`
* `mongodb`
* `openssl`
* `yum-epel`
* `yum-ius`
* `apache2`
* `varnish`
* `python`
* `nginx`
* `uwsgi`
* `yum`
* `apt`
* `git`  



Recipes
----------

#### apache
Creates sites coming from node['apache']['sites'] array
Creates monitoring check for each site if node[platformstack][cloud_monitoring] = enabled  

#### nginx
Creates sites coming from node['nginx']['sites'] array
Creates monitoring check for each site if node[platformstack][cloud_monitoring] = enabled  

#### application_python_nginx
Creates a configuration file for applications using variables for mysql_master node and rabbitmq node and placing this file in /etc/pythonstack.ini

#### format_disk
Includes stack_commons::format_disk which will format /dev/xvde1 (datadisk on Rackspace performance cloud nodes) this should not be called directly, if you want to format a disk for mysql usage use the recipe pythonstack::mysql_add_drive.

#### gluster
Includes stack_commons::gluster which sets up gluster nodes and replicas  

#### memcache
Includes stack_commons::memcached which installs and sets up cloud monitoring of memcached  

#### mongodb_standalone
Includes stack_commons::mongodb_standalone which sets up a standalone mongo db instance  

#### mysql_add_drive
Recipe will format /dev/xvde1 (datadisk on Rackspace performance cloud nodes) and will prepare it for the mysql datadir  

#### mysql_base
Includes recipe stack_commons::mysql_base to build a default standalone MySQL server.
Creates mysql-monitor template if node[platformstack][cloud_monitoring] = enabled
Creates an iptables rule for application_python nodes in order to connect to this one.

#### mysql_master
Includes stack_commons::mysql_master to build out a MySQL master server.
creates databases and associated database user per vhost

#### mysql_slave
Includes stack_commons::mysql_master to build out a MySQL slave server.

#### mysql_holland
Includes stack_commons::mysql_holland which doe the following:
Installs needed packages (holland and holland-mysqldump)
Verifies if this server is a slave or standalone
Setup a cronjob based on holland attributes

#### postgresql_base
Includes stack_commons::postgresql_base to setup a standalone postgresql server.
Sets up default IP tables rule to allow access on ['postgresql']['port']

#### postgresql_master
Includes stack_commons::postgresql_master to setup postgresql master server.

#### postgresql_slave
Includes stack_commons::postgresql_slave to setup postgresql slave server.

#### redis_base
Includes stack_commons::redis_base to setup a standalone redis service.

#### redis_master
Includes stack_commons::redis_master to setup a master redis node

#### redis_sentinel
Includes stack_commons::redis_sentinel to deploy redis-multi::sentinel

#### redis_single
Includes stack_commons::redis_single to deploy stack_commons::redis_base and redis-multi::single recipes

#### redis_slave
Includes stack_commons::redis_slave to deploy stack_commons::redis_base and redis-multi::slave

#### newrelic
Includes stack_commons::newrelic to install Newrelic if ```node['newrelic']['license'] ``` set with license key  

#### rabbitmq
Includes stack_commons::rabbitmq to installs Rabbitmq service

#### varnish
Includes stack_commons::varnish to installs and sets up Varnish.
Cloud monitoring enabled by default for thsi service.


####


Data_Bag
----------

No Data_Bag configured for this cookbook


Attributes
----------

### defaults

- `default['pythonstack']['newrelic']['application_monitoring'] = ''`
  - controls if we allow newrelic to to do application monitoring
    - is set to `'true'` in the newrelic recipe
- `default['pythonstack']['webserver'] = 'apache'`
  - sets the webserver want to use
    - you can set this to anything, but for actually running a webserver we only support nginx and apache
    - you can set this to something like `'not_a_webserver'` and then use that namespace if you still want to deploy your application
- `default['pythonstack']['ini']['cookbook'] = 'pythonstack'`
  - sets where the `/etc/phpstack.ini` template is sourced from
- `default['pythonstack']['mysql']['databases'] = {}`
  - contains a list of databases to set up (along with users / passwords)
- `default['pythonstack']['apache']['sites'] = {}`
  - contains a list of ports and vhosts to set up for apache
- `default['pythonstack']['nginx']['sites'] = {}`
  - contains a list of ports and vhosts to set up for nginx
- `default['pythonstack']['varish']['backend_nodes'] = {}`
  - contains a list of varnish nodes
- `default['pythonstack']['webserver_deployment']['enabled'] = true`
  - allows apache and/or nginx recipes to run
- `default['pythonstack']['code-deployment']['enabled'] = true`
  - allows code deployment to run
- `default['pythonstack']['db-autocreate']['enabled'] = true`
  - controls database autocreation for each site / port combination globally
- `default['pythonstack']['varnish']['multi'] = true`
  - controls deployment of varnish multi-node setup

### demo

contains attributes that used in a demo site, useful as an example of what to set to deploy a site

### monitoring

controls how cloud_monitoring is used within pythonstack

### nginx

controls setting within nginx configuration (ports, init scripts, etc)

### backups

controls the use of rackspace_cloudbackups on pythonstack

Usage
-----

https://github.com/rackspace-cookbooks/pythonstack/blob/master/USAGE.md


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md


Authors
-------
Authors:: Rackspace DevOps (devops@rackspace.com)
