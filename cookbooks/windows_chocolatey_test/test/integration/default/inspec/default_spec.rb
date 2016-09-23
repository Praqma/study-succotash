describe package('vagrant') do
  it { should be_installed }
end

describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\RegisteredApplications\Google Chrome') do
  it { should exist }
end

describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip\Path') do
  it { should exist }
end

describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Notepad++') do
  it { should exist }
end
