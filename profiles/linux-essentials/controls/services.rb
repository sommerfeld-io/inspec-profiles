title 'HTTP Service Check'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
mode = '0770'

control 'services-01' do
  impact 1.0
  title 'Ensure essential directories and files are present'
  desc 'Check for the presence of essential directories and files and their permissions
    Ansible tasks:
    * components/ansible/tasks/common-telemetry.yml'

  directories = [
  ]
  directories.each do |directory|
    describe file(directory) do
      it { should exist }
      it { should be_directory }
      it { should be_owned_by username }
      its('mode') { should cmp mode }
    end
  end
end

control 'http-01' do
  impact 1.0
  title 'Ensure HTTP services are running'
  desc 'Checks if the HTTP services are listening and are accessible'

  ports = [
    '9100', # node exporter
    '9110', # cAdvisor, 307 redirect to /containers
    '12345', # alloy
  ]
  ports.each do |port|
    describe port(port) do
      it { should be_listening }
      its('protocols') { should include 'tcp' }
    end

    describe host('localhost', port: port, protocol: 'tcp') do
      it { should be_reachable }
      it { should be_resolvable }
      its('protocol') { should eq 'tcp' }
    end

    describe http("http://localhost:#{port}") do
      its('status') { should be_in [200, 307] }
    end
  end
end
