#
# Author:: Eric Reeves (<eric@alertlogic.net>)
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2009-2012, Opscode, Inc.
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

package "postfix-mysql"

%w{ domains email2email forwardings mailboxes }.each do |cfg|

  template "/etc/postfix/mysql-virtual_#{cfg}.cf" do
    source "mysql-virtual_#{cfg}.cf.erb"
    owner "postfix"
    group "postfix"
    mode 00644
    notifies :restart, "service[postfix]"
    variables(
        :db_sid => node[:postfix][:db_sid],
        :db_user => node[:postfix][:db_user],
        :db_pass => node[:postfix][:db_pass]
    )
  end
end