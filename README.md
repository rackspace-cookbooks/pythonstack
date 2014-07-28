# pythonstack Cookbook
-------------------------------

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
* `mysql`
* `mysql-multi`
* `postgresql`
* `pg-multi`  

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
Includes recipe database::mysql, platformstack::monitors, mysql-multi::mysql_base
Creates mysql-monitor template if node[platformstack][cloud_monitoring] = enabled
Creates an iptables rule for application_python nodes in order to connect to this one.
#### mysql_master
Runs pythonstack::mysql_base along with mysql-multi::mysql_master recipes
#### mysql_slave
Runs pythonstack::mysql_base along with mysql-multi::mysql_slave recipes
#### mysql_holland
Setup an apt or yum repository for holland
Installs needed packages (holland and holland-mysqldump)
Verifies if this server is a slave or standalone
Setup a cronjob based on holland attributes
#### postgresql_base
Runs pg-multi::default recipe
Sets up default IP talbles rule to allow acces on ['postgresql']['port']
#### postgresql_master
Runs pythonstack::postgresql_base along with pg-multi::pg_master recipes
#### postgresql_slave
Runs pythonstack::postgresql_base along with pg-multi::pg_slave recipes

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
  * Define IP address of master MySQL node
* default['mysql-multi']['slaves'] = []
  * Define array of IP addresses for slave node(s)
* default['mysql-multi']['slave_user'] = 'replicant'
  * Used to customize replication user name
* ['mysql-multi']['server_repl_password'] = ['mysql']['server_repl_password']
  * Used to change replication user password

#### postgresql.rb

* default['postgresql']['password']['postgres'] = 'randompasswordforpostgresql'
  * Indicates admin password for postgresql
* default['pg-multi']['replication']['user'] = 'repl'
  * Used to customize replication username. 
* default['pg-multi']['replication']['password'] = 'useagudpasswd'
  * Used to set replication user password
* default['pg-multi']['master_ip'] = ''
  * Define Ip address of master node
* default['pg-multi']['slave_ip'] = []
  * Define array of IP addresses for slave node(s)
* default['postgresql']['enable_pdgd_yum'] = true  (needed for RedHat Family)
  * Used to enable needed repo for postgresql for RedHat family OS's
* default['postgresql']['enable_pdgd_apt'] = true  (needed for Debian Family)
  * Used to enable needed repo for postgresql for Debian family OS's

Usage
-----

https://github.com/AutomationSupport/pythonstack/blob/master/USAGE.md


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md


Authors
-------
Authors:: Rackspace DevOps (devops@rackspace.com)

