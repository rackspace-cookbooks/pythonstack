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
* `mysql`
* `nginx`
* `uwsgi`
* `yum`
* `apt`
* `git`  





Recipes
----------
#### default
Sets up webserver attributes depending on attribute ```['pythonstack']['webserver'] ``` value  

#### apache
Creates sites coming from node['apache']['sites'] array
Creates monitoring check for each site if node[platformstack][cloud_monitoring] = enabled  

#### nginx
Creates sites coming from node['nginx']['sites'] array
Creates monitoring check for each site if node[platformstack][cloud_monitoring] = enabled  

#### application_python_nginx
Creates a configuration file for applications using variables for mysql_master node and rabbitmq node and placing this file in /etc/pythonstack.ini 

#### format_disk  
Recipe will format /dev/xvde1 (datadisk on Rackspace performance cloud nodes) and will prepare it for the mysql datadir  

#### gluster 
Sets up gluster nodes and replica count  

#### memcache
Install memcached and sets up cloud monitoring of memcached  

#### mongodb_standalone
Sets up a stand alone mongo db instance  

#### mysql_add_drive 
Recipe will format /dev/xvde1 (datadisk on Rackspace performance cloud nodes) and will prepare it for the mysql datadir  

#### mysql_base
Includes recipe database::mysql, platformstack::monitors, mysql-multi::mysql_base
Creates mysql-monitor template if node[platformstack][cloud_monitoring] = enabled
Creates an iptables rule for application_python nodes in order to connect to this one.

#### mysql_master
Runs pythonstack::mysql_base along with mysql-multi::mysql_master recipes
creates db and associated user per vhost
use this if you are running on a single node

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

#### redis_base
Sets up a standalone redis node. It uses rackspace-support/redis-multi cookbook and includes redis-multi, redis-multi::single and redis-multi::enable and opens port in iptables.  

#### redis_master
Uses community cookbook redis-multi::master and Rackspace pythonstack::redis_base

#### redis_sentinel
Install sentinel using community cookbooks

#### redis_single
Uses Rackspace pythonstack::redis_base and community cookbook redis-multi::single

#### redis_slave
Uses Rackspace pythonstack::redis_base and community cookbook redis-multi::slave

#### newrelic
Install Newrelic if ```node['newrelic']['license'] ``` set with license key  

#### rabbitmq
Installs Rabbitmq

#### varnish
Installs and sets up Varnish. loud monitoring enabled by default


#### 


Data_Bag
----------

No Data_Bag configured for this cookbook


Attributes
----------


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['holland']['enabled']</tt></td>
    <td>boolean</td>
    <td>Sets mode (true | false)</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['holland']['password']</tt></td>
    <td>string</td>
    <td>Define password</td>
    <td><tt>'notagudpassword'</tt></td>
  </tr>
  <tr>
    <td><tt>['holland']['cron']['day']</tt></td>
    <td>string</td>
    <td>Set cron job day</td>
    <td><tt>'*'</tt></td>
  </tr>
  <tr>
    <td><tt>['holand']['cron']['hour']</tt></td>
    <td>string</td>
    <td>Set cron job hour</td>
    <td><tt>'3'</tt></td>
  </tr>
  <tr>
    <td><tt>['holland']['cron']['minute']</tt></td>
    <td>string</td>
    <td>Set cron job minute </td>
    <td><tt>'12'</tt></td>
  </tr>
  <tr>
    <td><tt>['pythonstack']['rackspace_cloudbackup']['http_docroot']['enable']</tt></td>
    <td>boolena</td>
    <td>Enable cloudbackup (true | false)</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['pythonstack']['newrelic']['application_monitoring']</tt></td>
    <td>string</td>
    <td>Set application name</td>
    <td><tt>''</tt></td>
  </tr>
    <tr>
    <td><tt>['pythonstack']['webserver']</tt></td>
    <td>string</td>
    <td>webserver to use (Nginx/Apache)</td>
    <td><tt>'apache'</tt></td>
  </tr>
    <tr>
    <td><tt>['pythonstack']['ini']['cookbook']</tt></td>
    <td>string</td>
    <td>Cookbook name</td>
    <td><tt>'pythonstack'</tt></td>
  </tr>
    <tr>
    <td><tt>['pythonstack']['code-deployment']['enabled']</tt></td>
    <td>boolena</td>
    <td>Enable code deployment (true | false)</td>
    <td><tt>true</tt></td>
  </tr>
    <tr>
    <td><tt>['pythonstack']['demo']['enabled']</tt></td>
    <td>boolean</td>
    <td>Is this a demo deployment?</td>
    <td><tt>false</tt></td>
  </tr>
  <td><tt>['pythonstack']['rabbitmq']['passwords']</tt></td>
    <td>array</td>
    <td>Define passwords</td>
    <td><tt>{}</tt></td>
  </tr>
    <td><tt>['pythonstack']['varnish']['multi']</tt></td>
    <td>boolean</td>
    <td>Is varnish mulit node</td>
    <td><tt>true</tt></td>
  </tr>
    <tr>
    <td><tt>['disk']['name']</tt></td>
    <td>string</td>
    <td>Define disk name</td>
    <td><tt>'/dev/xvde1'</tt></td>
  </tr>
    <tr>
    <td><tt>['disk']['fs']</tt></td>
    <td>string</td>
    <td>Disk file system</td>
    <td><tt>'ext4'</tt></td>
  </tr>
  <tr>
    <td><tt>['rackspace_gluster']['config']['server']['glusters']['Gluster Cluster 1']</tt></td>
    <td>Array</td>
    <td></td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['rackspace_gluster']['config']['server']['glusters']['Gluster Cluster 1']['volume']</tt></td>
    <td>string</td>
    <td>Define Volume</td>
    <td><tt>'vol10'</tt></td>
  </tr>
  <td><tt>['nginx']['default_site_enabled']</tt></td>
    <td>boolean</td>
    <td>Is default site enabled?</td>
    <td><tt>false</tt></td>
  </tr>
  <td><tt>['nginx']['init_style']'</tt></td>
    <td>string</td>
    <td>If platform ubuntu </td>
    <td><tt>'upstart'</tt></td>
  </tr>
  <td><tt>['nginx']['listen_ports']</tt></td>
    <td>string</td>
    <td>Set listening ports</td>
    <td><tt>'%w(80)'</tt></td>
  </tr>
  <td><tt>['nginx']['default_root']</tt></td>
    <td>string</td>
    <td>Default root path</td>
    <td><tt>'/var/www'</tt></td>
  </tr>
  <tr>
  <td><tt>['pythonstack']['cloud_monitoring']['remote_http']['disabled']</tt></td>
  <td>boolean</td>
  <td>Enable or Disable monitoring</td>
  <td><tt>false</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['remote_http']['alarm']</tt></td>
  <td>boolean</td>
  <td>Enable or disable monitor alarms </td>
  <td><tt>false</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['remote_http']['period']</tt></td>
  <td>int</td>
  <td>Interval in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['remote_http']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>15</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['disabled']</tt></td>
  <td>boolean</td>
  <td>Enable or Disable monitoring</td>
  <td><tt>false</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['alarm']</tt></td>
  <td>boolean</td>
  <td>Enable or Disable monitor alarms</td>
  <td><tt>false</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['period']</tt></td>
  <td>int</td>
  <td>Interval in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['user']</tt></td>
  <td>string</td>
  <td>Momyswl monitoring user</td>
  <td><tt>'raxmon-agent'</tt></td>
</tr>
<tr>
  <td><tt>['pythonstack']['cloud_monitoring']['agent_mysql']['password']</tt></td>
  <td>string</td>
  <td>Mysql monitor agent password</td>
  <td><tt>nil</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']</tt></td>
  <td>hash</td>
  <td>List of plugins to use</td>
  <td><tt>{}</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>'rabbitmq'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['disabled']</tt></td>
  <td>boolean</td>
  <td>Enable ort disable plugin</td>
  <td><tt>true</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['period']</tt></td>
  <td>int</td>
  <td>Interval in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>30</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['file_url']</tt></td>
  <td>string</td>
  <td>Plugin location</td>
  <td><tt>'https://raw.githubusercontent.com/racker/rackspace-monitoring-agent-plugins-contrib/master/rabbitmq.py'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['cookbook']</tt></td>
  <td>string</td>
  <td><Plugin cookbook name/td>
  <td><tt>'platformstack'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['details']['file']</tt></td>
  <td>string</td>
  <td>Plugin file name</td>
  <td><tt>'rabbitmq.py'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['details']['args']</tt></td>
  <td>array</td>
  <td></td>
  <td><tt>[]</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['details']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['alarm']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['alarm']['notification_plan_id']</tt></td>
  <td>string</td>
  <td>Notifaction plan name</td>
  <td><tt>'npMANAGED'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['rabbitmq']['alarm']['criteria']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>'varnish'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['disabled']</tt></td>
  <td>boolean</td>
  <td>Enable or disable varnish plugin</td>
  <td><tt>true</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['period']</tt></td>
  <td>int</td>
  <td>Interval in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>30</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['file_url']</tt></td>
  <td>string</td>
  <td>Plugin location</td>
  <td><tt>'https://raw.githubusercontent.com/racker/rackspace-monitoring-agent-plugins-contrib/master/varnish.sh'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['cookbook']</tt></td>
  <td>string</td>
  <td>Plugin cookbook name</td>
  <td><tt>'platformstack'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['details']['file']</tt></td>
  <td>string</td>
  <td>Plugin file name</td>
  <td><tt>'varnish.sh'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['details']['args']</tt></td>
  <td>array</td>
  <td></td>
  <td><tt>[]</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['details']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['alarm']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['alarm']['notification_plan_id']</tt></td>
  <td>string</td>
  <td>Notifaction plan name</td>
  <td><tt>'npMANAGED'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['varnish']['alarm']['criteria']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>'memcached'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['disabled']</tt></td>
  <td>boolean</td>
  <td>Enables or disables plugin</td>
  <td><tt>true</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['period']</tt></td>
  <td>int</td>
  <td>Interval in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>30</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['file_url']</tt></td>
  <td>string</td>
  <td>Plugin file location</td>
  <td><tt>'https://raw.githubusercontent.com/racker/rackspace-monitoring-agent-plugins-contrib/master/memcached_stats.py'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['cookbook']</tt></td>
  <td>string</td>
  <td>Plugin cookbook name</td>
  <td><tt>'platformstack'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['details']['file']</tt></td>
  <td>string</td>
  <td>Plugin file name</td>
  <td><tt>'memcached_stats.py'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['details']['args']</tt></td>
  <td>array</td>
  <td></td>
  <td><tt>[]</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['details']['timeout']</tt></td>
  <td>int</td>
  <td>Timeout in mins</td>
  <td><tt>60</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['alarm']['label']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['alarm']['notification_plan_id']</tt></td>
  <td>string</td>
  <td>Notifcation plan name</td>
  <td><tt>'npMANAGED'</tt></td>
</tr>
<tr>
  <td><tt>['platformstack']['cloud_monitoring']['plugins']['memcached']['alarm']['criteria']</tt></td>
  <td>string</td>
  <td></td>
  <td><tt>''</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['port']</tt></td>
  <td>int</td>
  <td>Define site port</td>
  <td><tt>80</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['cookbook']</tt></td>
  <td>string</td>
  <td>Cookbook name</td>
  <td><tt>'pythonstack'</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['template']</tt></td>
  <td>string</td>
  <td>Site templatet location</td>
  <td><tt>"apache2/sites/#{site1.erb}"</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['server_name']</tt></td>
  <td>variable</td>
  <td>Sites server name</td>
  <td><tt>site1</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['server_alias']</tt></td>
  <td>array</td>
  <td>Sites server name alias</td>
  <td><tt>["test.#{site1}", "www.#{site1}"]</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['docroot']</tt></td>
  <td>string</td>
  <td>Sites document root name</td>
  <td><tt>"#{node['apache']['docroot_dir']}/#{site1}"</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['errorlog']</tt></td>
  <td>string</td>
  <td>Sites error log location</td>
  <td><tt>"#{node['apache']['log_dir']}/#{site1}-error.log"</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['customlog']</tt></td>
  <td>string</td>
  <td>Sites custom log location</td>
  <td><tt>"#{node['apache']['log_dir']}/#{site1}-access.log combined"</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['allow_override']</tt></td>
  <td>array</td>
  <td></td>
  <td><tt>['ALL']</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['loglevel']</tt></td>
  <td>string</td>
  <td>Sites logging level</td>
  <td><tt>'warn'</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['script_name']</tt></td>
  <td>string</td>
  <td>Sites script name</td>
  <td><tt>'wsgi.py'</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['server_admin']</tt></td>
  <td>string</td>
  <td>Sites admin mail address</td>
  <td><tt>'demo@demo.com'</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['revision']</tt></td>
  <td>string</td>
  <td>Site version</td>
  <td><tt>"v#{version1}"</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['repository']</tt></td>
  <td>string</td>
  <td>Sites app repo location</td>
  <td><tt>'https://github.com/rackops/flask-test-app'</tt></td>
</tr>
<tr>
  <td><tt>['apache']['sites'][site1]['deploy_key']</tt></td>
  <td>string</td>
  <td>Sites deploymnet key</td>
  <td><tt>'/root/.ssh/id_rsa'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['port']</tt></td>
  <td>int</td>
  <td>Define sites port</td>
  <td><tt>80</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['uswgi_port']</tt></td>
  <td>int</td>
  <td>Define sites uswgi port</td>
  <td><tt>8080</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['uswgi_stats_port']</tt></td>
  <td>string</td>
  <td>Define sites uswgi stats port</td>
  <td><tt>'1717'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['uswgi_options']</tt></td>
  <td>hash</td>
  <td>Define uswgi option</td>
  <td><tt>{}</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['cookbook']</tt></td>
  <td>string</td>
  <td>Sites cookbook name</td>
  <td><tt>'pythonstack'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['server_name']</tt></td>
  <td>variable</td>
  <td>Sites server name</td>
  <td><tt>site1</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['server_alias']</tt></td>
  <td>array</td>
  <td>Sites server alias</td>
  <td><tt>["test.#{site1}", "www.#{site1}"]</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['docroot']</tt></td>
  <td>string</td>
  <td>Sites document root</td>
  <td><tt>"#{node['nginx']['default_root']}/#{site1}"</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['errorlog']</tt></td>
  <td>string</td>
  <td>Site error log location</td>
  <td><tt>"#{node['nginx']['log_dir']}/#{site1}-error.log"</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['customlog']</tt></td>
  <td>string</td>
  <td>Sites custom log location c</td>
  <td><tt>"#{node['nginx']['log_dir']}/#{site1}-access.log combined"</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['loglevel']</tt></td>
  <td>string</td>
  <td>Sites logging level</td>
  <td><tt>'warn'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['app']</tt></td>
  <td>string</td>
  <td>Application name</td>
  <td><tt>'demo:app'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['revision']</tt></td>
  <td>string</td>
  <td>Site version</td>
  <td><tt>"v#{version1}"</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['repository']</tt></td>
  <td>string</td>
  <td>Sites app repo location</td>
  <td><tt>'https://github.com/rackops/flask-test-app'</tt></td>
</tr>
<tr>
  <td><tt>['nginx']['sites'][site1]['deploy_key']</tt></td>
  <td>string</td>
  <td>Site deployment key</td>
  <td><tt>'/root/.ssh/id_rsa'</tt></td>
</tr>
</table>  



Usage
-----

https://github.com/AutomationSupport/pythonstack/blob/master/USAGE.md


Contributing
------------

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md


Authors
-------
Authors:: Rackspace DevOps (devops@rackspace.com)

