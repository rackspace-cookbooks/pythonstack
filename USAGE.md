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

* Building MySQL cluster for pythonstack.

Ensure the following attributes are set within environment or wrapper cookbook.

['mysql']['server_repl_password'] = 'rootlogin'
['mysql']['server_repl_password'] = 'replicantlogin'
['mysql-multi']['master'] = '1.2.3.4'
['mysql-multi']['slaves'] = ['5.6.7.8']

Master node:
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::mysql_master]"
  ]
}
```

Slave node:
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::mysql_slave]"
  ]
}
```

* Building a PostgreSQL cluster for pythonstack.

Ensure the following attributes are set within environment or wrapper cookbook.

['postgresql']['version'] = '9.3' 
['postgresql']['password'] = 'postgresdefault'
['pg-multi']['replication']['password'] = 'useagudpasswd'
['pg-multi']['master_ip'] = '1.2.3.4'
['pg-multi']['slave_ip'] = ['5.6.7.8']

Depending on OS one of the following two must be set:
['postgresql']['enable_pdgd_yum'] = true  (Redhat Family)
['postgresql']['enable_pdgd_apt'] = true  (Debian Family)

Master node:
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::postgresql_master]"
  ]
}
```
Slave node:
```json
{
  "run_list": [
  "recipe[platformstack::default]",
  "recipe[rackops_rolebook::default]",
  "recipe[pythonstack::postgresql_slave]"
  ]
}
```
