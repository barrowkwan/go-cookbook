##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
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
##########################################################################

require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'golang agent package' do
  it 'should be installed' do
    expect(file('/usr/bin/gocd-golang-agent')).to exist
  end
  it 'java agent should not be installed' do
    expect(package('go-agent')).to_not be_installed
  end
end

describe 'go agent service' do
  it 'process should be running' do
    expect(process('gocd-golang-agent')).to be_running
  end
end

describe '/etc/default/go-agent' do
  it 'should have the correct ownership and mode' do
    expect(file('/etc/default/go-agent')).to exist
    expect(file('/etc/default/go-agent')).to be_readable
    expect(file('/etc/default/go-agent')).to be_mode(644)
    expect(file('/etc/default/go-agent')).to be_owned_by('root')
    expect(file('/etc/default/go-agent')).to be_grouped_into('root')
  end
end
