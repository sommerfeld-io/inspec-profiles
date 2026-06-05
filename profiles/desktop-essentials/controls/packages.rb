title 'Ensure desktop-specific packages are installed'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
mode = '0755'

if os.arch == 'x86_64'
  control 'packages-01-amd64' do
    impact 1.0
    title 'Check for amd64 specific desktop packages'
    desc 'Ensure desktop-specific amd64 packages are installed on Ubuntu desktop nodes'

    should_exist = [
      '/usr/bin/chromium-browser',
      '/usr/bin/conky',
      '/usr/bin/filezilla',
      '/usr/bin/p7zip',
      '/usr/bin/rar',
      '/usr/bin/rpi-imager',
      '/usr/bin/subl', # sublime text
      '/usr/bin/tilix',
      '/usr/bin/unrar',
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end
  end

  control 'packages-02-amd64' do
    impact 1.0
    title 'Check for amd64 specific desktop snap packages'
    desc 'Ensure desktop-specific snap packages are installed on Ubuntu desktop nodes'

    should_exist = [
      '/snap/bin/code',
      '/snap/bin/postman',
      '/snap/bin/spotify',
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end

    should_not_exist = [
      '/snap/bin/intellij-idea-community',
      '/snap/bin/intellij-idea-ultimate',
    ]
    should_not_exist.each do |binary|
      describe file(binary) do
        it { should_not exist }
      end
    end
  end

  control 'packages-03-amd64' do
    impact 1.0
    title 'Check for amd64 specific desktop media packages'
    desc 'Ensure desktop-specific media packages are installed on Ubuntu desktop nodes'

    should_exist = [
      '/usr/bin/asunder',
      '/usr/bin/brasero',
      '/usr/bin/vlc',
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end
  end

  control 'packages-04-amd64' do
    impact 1.0
    title 'Check for absent desktop packages'
    desc 'Ensure desktop nodes do not retain excluded or deprecated packages'

    should_not_exist = [
      '/usr/bin/balena-etcher',
    ]
    should_not_exist.each do |binary|
      describe file(binary) do
        it { should_not exist }
      end
    end
  end
end
