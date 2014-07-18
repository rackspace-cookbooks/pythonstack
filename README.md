# pythonstack Cookbook

Supported Platforms
-------------------
* Ubuntu 12.04

Requirements
------------
#### Cookbooks
  
* `git` 
* `rackops_rolebook`  
* `yum`  
* `apt`  
* `chef-sugar`  
* `platformstack::monitors`  
* `platformstack::iptables`  
* `apache2`  
* `apache2::mod_wscgi`  
* `database::mysql`  
* `mysql:server`
* `mysql-multi::mysql_base`  

Recipes
----------
#### default
#### apache
Includes recipes: platformstack::monitors platformstack::iptables apt apache2::default apache2::mod_wscgi apache2::mod_python
Creates sites coming from node['apache']['sites'] array
Creates monitoring check for each site if node[platformstack][cloud_monitoring] = enabled
#### application_python
Includes recipes: git, yum, yum-epel, yum-ius, apt, php, php::ini, php::module_mysql, pythonstack::apache, pythonstack::php_fpm, chef-sugar
Creates application_deployment configuration, checking out the code from node['apache']['sites']['repository'] and putting into the path specified in node['apache']['sites']['docroot']
Creates a configuration file for applications using variables for mysql_master node and rabbitmq node and placing this file in /etc/pythonstack.ini
#### mysql_base
Includes recipe database::mysql, platformstack::monitors, mysql::server, mysql-multi::mysql_base
Set mysql passwords dynamically
Creates mysql-monitor template if node[platformstack][cloud_monitoring] = enabled
Creates an iptables rule for application_python nodes in order to connect to this one.
#### mysql_holland
Setup an apt or yum repository for holland
Installs needed packages (holland and holland-mysqldump)
Verifies if this server is a slave or standalone
Setup a cronjob based on holland attributes

Data_Bag
----------

No Data_Bag configured for this cookbook


Attributes
----------

#### apache.rb
* site1 = 'example.com'
  * Indicate the fqdn of the site number 1
* node.default['apache']['sites'][site1]['port']         = 80
  * Indicates what port should be this site listening on
* node.default['apache']['sites'][site1]['cookbook']     = 'pythonstack'
  * Indicates the name of the cookbook to get templates from
* node.default['apache']['sites'][site1]['template']     = "apache2/sites/#{site1}.erb"
  * Indicates template file location for this site
* node.default['apache']['sites'][site1]['server_name']  = site1
  * Indicates server_name variable to be used in template file
* node.default['apache']['sites'][site1]['server_alias'] = ["test.#{site1}", "www.#{site1}"]
  * Indicates server_alias variable to be used in template file
* node.default['apache']['sites'][site1]['docroot']      = "/var/www/#{site1}"
  * Indicates docroot variable to be used in template file
* node.default['apache']['sites'][site1]['allow_override'] = ['All']
  * Indicates allow_override variable to be used in template file
* node.default['apache']['sites'][site1]['errorlog']     = "#{node['apache']['log_dir']}/#{site1}-error.log"
  * Indicates errorlog variable to be used in template file
* node.default['apache']['sites'][site1]['customlog']    = "#{node['apache']['log_dir']}/#{site1}-access.log combined"
  * Indicates customlog variable to be used in template file
* node.default['apache']['sites'][site1]['loglevel']     = 'warn'
  * Indicates loglevel variable to be used in template file
* node.default['apache']['sites'][site1]['server_admin'] = 'demo@demo.com'
  * Indicates server_admin variable to be used in template file
* node.default['apache']['sites'][site1]['revision'] = "v#{version1}"
  * Indicates revision variable to be used to deploy this site files
* node.default['apache']['sites'][site1]['repository'] = 'https://github.com/rackops/php-test-app'
  * Indicates repository variable to be used to deploy this site
* node.default['apache']['sites'][site1]['deploy_key'] = '/root/.ssh/id_rsa'
  * Indicates deploy_key variable to be used when getting data from repository

#### holland.rb

* default['holland']['enabled'] = false
  * Defines if holland is enabled or not in this node
* default['holland']['password'] = 'notagudpassword'
  * Defines the password for holland user in mysql database
* default['holland']['cron']['day'] = '*'
  * Defines day for backup
* default['holland']['cron']['hour'] = '3'
  * Defines hour for backup
* default['holland']['cron']['minute'] = '12'
  * Defines minute for backup

#### monitoring.rb

* default['pythonstack']['cloud_monitoring']['remote_http']['disabled'] = false
* default['pythonstack']['cloud_monitoring']['remote_http']['alarm'] = false
* default['pythonstack']['cloud_monitoring']['remote_http']['period'] = 60
* default['pythonstack']['cloud_monitoring']['remote_http']['timeout'] = 15
* default['pythonstack']['cloud_monitoring']['agent_mysql']['disabled'] = false
* default['pythonstack']['cloud_monitoring']['agent_mysql']['alarm'] = false
* default['pythonstack']['cloud_monitoring']['agent_mysql']['period'] = 60
* default['pythonstack']['cloud_monitoring']['agent_mysql']['timeout'] = 15
* default['pythonstack']['cloud_monitoring']['agent_mysql']['user'] = 'raxmon-agent'
* default['pythonstack']['cloud_monitoring']['agent_mysql']['password'] = nil

#### mysql.rb

* default['mysql-multi']['master'] = ''
* default['mysql-multi']['slaves'] = []
* default['mysql-multi']['slave_user'] = 'replicant'

#### postgresql.rb
* default['postgresql']['password']['postgres'] = 'randompasswordforpostgresql'
  * Indicates admin password for postgresql

Usage
-----

#### pythonstack

* single node (app and db) 
	Include recipe `platformstack::default`, `rackops_rolebook::default`, `pythonstack::mysql_base`, `pythonstack::application_python` in your node's `run_list`:    
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::mysql_base]",
  "recipe[pythonstack::application_python]
  ]
}
```
* single app node - standalone db node 
  DB Node: Include recipe `platformstack::default`, `rackops_rolebook::default`, `pythonstack::mysql_base` in your node's `run_list`:    
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::mysql_base]",
  "recipe[pythonstack::application_python]
  ]
}
```

  App Node: Include recipe `platformstack::default`, `rackops_rolebook::default`, `pythonstack::application_python` in your node's `run_list`:    
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::application_python]
  ]
}
```


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md


Authors
-------
Authors:: Rackspace DevOps (devops@rackspace.com)

