# we wrote our own LWRP to decypt files:

ops_encryptedfile file do
  dest_file dest_file
  source_file source_file
  files_dir files_dir
  diffrun diffrun
  owner node[:config][:role_user]
  mode "0700"
  group 'roleusers'
  action :decrypt
end
