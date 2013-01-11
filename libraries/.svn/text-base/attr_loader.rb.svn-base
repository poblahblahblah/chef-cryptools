require 'open3'
require 'chef/log'

# we load up our yaml files and dump them into the chef attribute 'node'  here.
# this probably isn't how it's typically done in chef (the typical usage is to 
# just keep defining new key, value pairs as if you were doing it for a regular
# ruby file) and it can probably be done better.
module AttrLoader
  def self.load_me(dir, node)
    yaml_list      = Dir.glob("#{dir}/*.yaml")
    cookbook       = Dir.glob("#{dir}").to_s.split('/')[-2]
    node[cookbook] = {}
    node[cookbook][:stderr] = []

    yaml_list.each do |yaml|
      yaml_key = File.basename(yaml).split('.')[0]
      if File.basename(yaml) =~ /#{yaml_key}.yaml$/
        File.open(yaml) do |file|
          # let's do a check to see if the file is encrypted. if it is, fix that.
          if Cryptools.is_gpg_encrypted?(yaml)
            #file, stderr = Cryptools.unencrypt_gpg(file.path, "/root/.gnupg/secring.gpg", "release-svc")
            #node[cookbook][:stderr] = stderr
            stdin, stdout, stderr = Open3.popen3("gpg -q --yes -r release-svc --secret-keyring /root/.gnupg/secring.gpg --decrypt #{file.path}")
            stderr.each do |x|
              node[cookbook][:stderr] << "#{file.path.split('/')[-1]} \"#{x.strip.gsub(' ', '_')}\""
            end
            file = stdout.read
          end
          begin
            YAML.load_documents(file) do |y|
              node[cookbook][yaml_key] = y
            end
          rescue => exception
             Chef::Log.error("Malformed YAML found for #{cookbook} - #{file}: #{exception}")
          end
        end
      end
    end
  end
end
