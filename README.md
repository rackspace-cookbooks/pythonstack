# pythonstack Cookbook
-------------------------------

Supported Platforms
-------------------
* Ubuntu 12.04
* Centos 6.5

Requirements
------------
#### Cookbooks

* `apache2`
* `application`
* `application_python`
* `apt`
* `chef-sugar`
* `database`
* `git`
* `memcached`
* `mongodb`
* `mysql-multi`
* `mysql`
* `newrelic`
* `openssl`
* `pg-multi`
* `platformstack`
* `python`
* `rackspace_gluster`
* `redis-multi`
* `stack_commons`
* `uwsgi`
* `yum`
* `yum-epel`
* `yum-ius`


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


Data_Bag
----------

No Data_Bag configured for this cookbook


Attributes
----------

### defaults

- `default['pythonstack']['webserver'] = 'apache'`
  - sets the webserver want to use
    - you can set this to anything, but for actually running a webserver we only support nginx and apache
    - you can set this to something like `'not_a_webserver'` and then use that namespace if you still want to deploy your application
- `default['pythonstack']['ini']['cookbook'] = 'pythonstack'`
  - sets where the `/etc/phpstack.ini` template is sourced from
- `default['pythonstack']['apache']['sites'] = {}`
  - contains a list of ports and vhosts to set up for apache
- `default['pythonstack']['nginx']['sites'] = {}`
  - contains a list of ports and vhosts to set up for nginx
- `default['pythonstack']['webserver_deployment']['enabled'] = true`
  - allows apache and/or nginx recipes to run
- `default['pythonstack']['code-deployment']['enabled'] = true`
  - allows code deployment to run

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
