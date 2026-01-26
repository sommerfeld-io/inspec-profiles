title 'Global System Configuration'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
default_mode = input('default_mode', value: '0755')

control 'system-01' do
  title 'Verify Operating System Version'
  desc 'Ensure the operating system version is as expected'

  describe os.name do
    it { should be_in ['ubuntu', 'arch'] }
  end

  describe os.release do
    it { should be_in ['25.04', '25.10'] } if os.name == 'ubuntu'
  end
end
