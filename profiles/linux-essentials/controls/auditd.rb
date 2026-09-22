title 'Ensure audit daemon configuration is aligned with the operating system'

if ['ubuntu', 'arch'].include?(os.name)
  control 'auditd-01' do
    impact 1.0
    title 'Audit Daemon Config'
    desc 'Ensure audit daemon settings match the expected defaults for the operating system'

    expected_log_format = os.name == 'arch' ? 'ENRICHED' : 'raw'
    expected_max_log_file_action = os.name == 'arch' ? 'ROTATE' : 'keep_logs'

    describe auditd_conf do
      its('log_format') { should cmp expected_log_format }
      its('max_log_file_action') { should cmp expected_max_log_file_action }
    end
  end
end
