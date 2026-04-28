title 'Docker Checks'

control 'docker-01' do
  impact 1.0
  title 'Check for amd64 specific docker packages'
  desc 'Ensure amd64 specific docker packages are installed (desktop workstations)'

  should_exist = [
    '/usr/bin/docker',
  ]
  should_exist.each do |binary|
    describe file(binary) do
      it { should exist }
      its('mode') { should cmp mode }
    end
  end
end

control 'docker-02' do
  impact 1.0
  title 'Ensure Docker is installed'
  desc 'Ensure Docker is installed in correct version'

  describe docker.version do
    its('Server.Version') { should cmp >= '29.1.1'}
    its('Client.Version') { should cmp >= '29.1.1'}
  end
end
