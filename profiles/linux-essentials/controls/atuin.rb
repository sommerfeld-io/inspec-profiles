title 'Ensure atuin is installed'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')

control 'atuin-01' do
  impact 1.0
  title 'Check for atuin'
  desc 'Ensure atuin is installed'

  should_exist = [
    "/home/#{username}/.atuin/bin/atuin",
  ]
  should_exist.each do |binary|
    describe file(binary) do
      it { should exist }
      its('mode') { should cmp '0755' }
    end
  end
end
