require 'fileutils'

action :decrypt do
  if @new_resource.diffrun
    Chef::Log.debug("{\"encrypted_file\": \"#{@new_resource.dest_file}\", \"md5\": \"#{`/usr/bin/md5sum #{@new_resource.files_dir + @new_resource.source_file}`.split[0]}\"}")
  else
    `cat #{@new_resource.files_dir + @new_resource.source_file} | gpg -q --yes -r release-svc --secret-keyring #{@new_resource.gpg_key} -o #{@new_resource.dest_file} --decrypt`
    mode = @new_resource.mode
    mode = ((mode.respond_to?(:oct) ? mode.oct : mode.to_i) & 007777)
    FileUtils.chmod(mode, @new_resource.dest_file)
    FileUtils.chown(@new_resource.owner, @new_resource.group, @new_resource.dest_file)
  end
end
