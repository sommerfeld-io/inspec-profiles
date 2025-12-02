title 'Bash Configuration Check'

username = input('username', value: 'default_user')
emailAddress = input('emailAddress', value: 'noreply@example.com')
default_mode = input('default_mode', value: '0755')

bashrc_path = "/home/#{username}/.bashrc"
bash_aliases_path = "/home/#{username}/.bash_aliases"

control 'bash-01' do
  impact 1.0
  title "Ensure environment variables are set in #{bashrc_path}"
  desc "Check if the required environment variables are present in the #{bashrc_path} file"

  describe file(bashrc_path) do
    it { should exist }
    it { should be_file }
    its('content') { should include 'export LOG_DONE="[\e[32mDONE\e[0m]"' }
    its('content') { should include 'export LOG_ERROR="[\e[1;31mERROR\e[0m]"' }
    its('content') { should include 'export LOG_INFO="[\e[34mINFO\e[0m]"' }
    its('content') { should include 'export LOG_WARN="[\e[93mWARN\e[0m]"' }
    its('content') { should include 'export Y="\e[93m"' }
    its('content') { should include 'export P="\e[35m"' }
    its('content') { should include 'export B="\e[94m"' }
    its('content') { should include 'export D="\e[0m"' }
    its('content') { should include "export G='\\033[1;30m'" }
    its('content') { should include 'alias ll="ls -alFh --color=auto"' }
    its('content') { should include 'alias ls="ls -a --color=auto"' }
    its('content') { should include 'alias grep="grep --color=auto"' }
    its('content') { should include 'alias pull-all-repos="git all pull"' }
  end
end

control 'bash-02' do
  impact 1.0
  title "Ensure #{bash_aliases_path} does not exist"
  desc "Check that the #{bash_aliases_path} file has been removed"

  describe file(bash_aliases_path) do
    it { should_not exist }
  end
end

control 'bash-03' do
  impact 0.3
  title "Ensure PS1 prompt is overridden in #{bashrc_path}"
  desc "Check if the PS1 prompt is overridden in the #{bashrc_path} file"

  describe file(bashrc_path) do
    it { should exist }
    it { should be_file }
    its('content') { should match(/^export PS1=/) }
  end
end
