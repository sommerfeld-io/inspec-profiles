title 'Ensure packages are installed'

username = input('username', value: 'default_user')
mode = input('mode', value: '0755')

control 'ollama-packages-01' do
  impact 1.0
  title 'Check for essential ollama packages'
  desc 'Ensure essential ollama packages are installed'

  should_exist = [
    '/usr/local/bin/ollama',
  ]
  should_exist.each do |binary|
    describe file(binary) do
      it { should exist }
      its('mode') { should cmp mode }
    end
  end
end
