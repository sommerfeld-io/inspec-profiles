title 'User Existence'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
default_mode = input('default_mode', value: '0755')

ssh_key_path = "/home/#{username}/.ssh/id_rsa"

control 'user-01' do
  impact 1.0
  title 'Check if the user exists and uses bash as the default shell'
  desc 'Ensure the specified user exists and has bash as their default shell'

  describe user(username) do
    it { should exist }
    its('shell') { should eq '/bin/ash' } if file('/etc/os-release').content.match?(/Alpine/)
    its('shell') { should eq '/bin/bash' } if file('/etc/os-release').content.match?(/(Ubuntu|Arch)/)
  end
end
