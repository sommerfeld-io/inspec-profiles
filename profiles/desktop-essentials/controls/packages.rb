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
      '/usr/bin/conky',
      '/usr/bin/filezilla',
      '/usr/bin/rpi-imager',
      '/usr/bin/subl', # sublime text
    ]
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end

    # Chromium is installed via apt as chromium-browser on Ubuntu, but via pacman as
    # chromium (binary /usr/bin/chromium) on Arch/Omarchy.
    chromium_path = os.name == 'ubuntu' ? '/usr/bin/chromium-browser' : '/usr/bin/chromium'
    describe file(chromium_path) do
      it { should exist }
      its('mode') { should cmp mode }
    end

    # Tilix, rar, unrar and p7zip have no Arch package yet (open TODO in the packages
    # role's desktop/10-basics.yml) and are only installed on Ubuntu.
    if os.name == 'ubuntu'
      should_exist_ubuntu_only = [
        '/usr/bin/p7zip',
        '/usr/bin/rar',
        '/usr/bin/tilix',
        '/usr/bin/unrar',
      ]
      should_exist_ubuntu_only.each do |binary|
        describe file(binary) do
          it { should exist }
          its('mode') { should cmp mode }
        end
      end
    end
  end

  control 'packages-02-amd64' do
    impact 1.0
    title 'Check for amd64 specific desktop snap packages'
    desc 'Ensure VS Code and Spotify are installed on Ubuntu (snap) and Arch/Omarchy (native package) desktop nodes'

    # VS Code and Spotify come from snap on Ubuntu, but from a native package (AUR via
    # yay for VS Code, pacman for Spotify) on Arch/Omarchy.
    should_exist = if os.name == 'ubuntu'
                     [
                       '/snap/bin/code',
                       '/snap/bin/spotify',
                     ]
                   else
                     [
                       '/usr/bin/code',
                       '/usr/bin/spotify',
                     ]
                   end
    should_exist.each do |binary|
      describe file(binary) do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end

    # Postman and IntelliJ IDEA are removed entirely - never installed on any OS, and
    # actively uninstalled/purged where they previously were on Ubuntu.
    should_not_exist = [
      '/snap/bin/intellij-idea-community',
      '/snap/bin/intellij-idea-ultimate',
      '/snap/bin/postman',
      '/usr/bin/postman',
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

    describe file('/usr/bin/vlc') do
      it { should exist }
      its('mode') { should cmp mode }
    end

    # brasero has no Arch package (its pacman install is commented out in the packages
    # role's desktop/50-media-players.yml) and is only installed on Ubuntu.
    if os.name == 'ubuntu'
      describe file('/usr/bin/brasero') do
        it { should exist }
        its('mode') { should cmp mode }
      end
    end
  end

  control 'packages-04-amd64' do
    impact 1.0
    title 'Check for absent desktop packages'
    desc 'Ensure desktop nodes do not retain excluded or deprecated packages'

    # asunder and brasero-on-Arch are removed entirely - never installed on any OS, and
    # actively uninstalled/purged where they previously were on Ubuntu.
    should_not_exist = [
      '/usr/bin/asunder',
      '/usr/bin/balena-etcher',
    ]
    should_not_exist << '/usr/bin/brasero' unless os.name == 'ubuntu'
    should_not_exist.each do |binary|
      describe file(binary) do
        it { should_not exist }
      end
    end
  end
end
