title 'Global System Configuration'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')

control 'system-01' do
  title 'Verify Operating System Version'
  desc 'Ensure the operating system version is as expected'

  describe os.name do
    it { should be_in ['ubuntu', 'arch'] }
  end

  describe os.release do
    it { should be_in ['26.04', '26.10'] } if os.name == 'ubuntu'
  end
end

control 'system-02' do
  impact 1.0
  title 'Verify kernel parameter defaults'
  desc 'Ensure Arch kernel parameter defaults match the expected operating system settings'

  only_if('This kernel parameter override is only expected on Arch Linux') do
    os.name == 'arch'
  end

  describe kernel_parameter('fs.protected_regular') do
    its('value') { should eq 1 }
  end
end
