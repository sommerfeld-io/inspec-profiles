title 'Ensure common packages are installed'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
mode = '0755'

control 'packages-01' do
  impact 1.0
  title 'Check for essential tools'
  desc 'Ensure essential tools are installed'

  should_exist = [
    '/usr/bin/curl',
    '/usr/bin/htop',
    '/usr/bin/jq',
    '/usr/bin/make',
    '/usr/bin/ncdu',
    '/usr/bin/fastfetch',
    '/usr/bin/vim',
  ]
  should_exist.each do |binary|
    describe file(binary) do
      it { should exist }
      its('mode') { should cmp mode }
    end
  end
end

if os.arch == 'x86_64'
  control 'packages-02-amd64' do
    impact 1.0
    title 'Check for shared amd64 packages'
    desc 'Ensure shared amd64 packages are installed on Ubuntu desktop and server nodes'

    should_exist = [
      '/usr/bin/ansible',
      '/usr/bin/gh',
      '/usr/bin/nmap',
      '/usr/bin/hostnamectl',
      '/usr/local/bin/ctop',
      '/usr/bin/node',
      '/usr/bin/npm',
      '/usr/bin/npx',
      '/usr/bin/pre-commit',
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end

    should_not_exist = [
      '/usr/bin/asciidoctor',
      '/usr/bin/minikube',
      '/usr/bin/yarn',
      '/usr/local/bin/helm',
    ]
    should_not_exist.each do |binary|
      describe file(binary) do
        it { should_not exist }
      end
    end
  end

  control 'packages-03-amd64-node-applications' do
    impact 1.0
    title 'Check for amd64 specific node applications'
    desc 'Ensure amd64 specific node applications are installed on Ubuntu desktop and server nodes'

    should_exist = [
      "/home/#{username}/.local/bin/gemini",
      "/home/#{username}/.local/bin/copilot",
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp 0770 }
      end
    end

  end

  control 'packages-06-virtualization' do
    impact 1.0
    title 'Check for virtualization packages on amd64'
    desc 'Ensure virtualization packages on amd64 machines are installed'

    should_exist = [
      '/usr/bin/vagrant',
      '/usr/bin/virtualbox',
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end
  end
end

if os.arch == 'aarch64'
  control 'packages-02-arm64' do
    impact 1.0
    title 'Check for arm64 specific tools'
    desc 'Ensure arm64 specific tools are installed'

    should_exist = [
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end
  end
end
