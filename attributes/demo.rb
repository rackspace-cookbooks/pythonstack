# Encoding: utf-8
#
# Cookbook Name:: pythonstack
#
# Copyright 2014, Rackspace UK, Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['pythonstack']['demo']['enabled'] = false

site1 = 'example.com'
site2 = 'test.com'
version1 = '0.0.9'
port1 = '80'
port2 = '8080'

# apache site1
default['pythonstack']['demo']['apache']['sites'][port1][site1]['server_alias']   = [site1, "test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['apache']['sites'][port1][site1]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['apache']['sites'][port2][site1]['server_alias']   = [site1, "test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['apache']['sites'][port2][site1]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['deploy_key']     = '/root/.ssh/id_rsa'

# apache site2
default['pythonstack']['demo']['apache']['sites'][port1][site2]['server_alias']   = [site2, "test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['apache']['sites'][port1][site2]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['apache']['sites'][port2][site2]['server_alias']   = [site2, "test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['apache']['sites'][port2][site2]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['deploy_key']     = '/root/.ssh/id_rsa'

# nginx site1
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['server_alias']   = [site1, "test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['nginx']['sites'][port2][site1]['server_alias']   = [site1, "test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['deploy_key']     = '/root/.ssh/id_rsa'

# nginx site2
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['server_alias']   = [site2, "test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['nginx']['sites'][port2][site2]['server_alias']   = [site2, "test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['repository']     = 'https://github.com/rackops/flask-test-app'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['deploy_key']     = '/root/.ssh/id_rsa'
