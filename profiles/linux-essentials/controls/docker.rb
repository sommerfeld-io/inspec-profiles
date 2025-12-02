title 'Docker Checks'

control 'docker-01' do
  impact 1.0
  title 'Ensure Docker is installed'
  desc 'Ensure Docker is installed in correct version'

  describe docker.version do
    its('Server.Version') { should cmp >= '29.1.1'}
    its('Client.Version') { should cmp >= '29.1.1'}
  end
end
