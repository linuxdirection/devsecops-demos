control "nginx_installed" do
    title "Verify nginx is installed"
    describe package('nginx') do
      it { should be_installed }
    end
  end
  
  control "python3_installed" do
    title "Verify Python 3 is installed"
    describe package('python3') do
      it { should be_installed }
    end
  end
  
  control "nginx_running" do
    title "Verify nginx is running and enabled"
    describe service('nginx') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  end
  
  control "passwd_permissions" do
    title "Verify permissions on /etc/passwd"
    describe file('/etc/passwd') do
      it { should exist }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its('mode') { should cmp '0644' }
    end
  end
  
  control "unused_filesystems" do
    title "Verify unused filesystems are disabled"
    describe mount('none') do
      its('type') { should_not cmp 'cramfs' }
    end
  end
  
  control "password_policy" do
    title "Verify password policy is set"
    describe file('/etc/pam.d/common-password') do
      its('content') { should match /^password\s+requisite\s+pam_pwquality\.so.*retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 enforce_for_root$/ }
    end
  end
  