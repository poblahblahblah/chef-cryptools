def initialize(*args)
  super
  @action = :decrypt
end

actions :decrypt

attribute :gpg_key,     :kind_of => String, :default => "/root/.gnupg/secring.gpg"
attribute :dest_file,   :kind_of => String
attribute :source_file, :kind_of => String
attribute :files_dir,   :kind_of => String
attribute :diffrun,     :default => false
attribute :mode,        :default => 0700, :regex => /^0?\d{3,4}$/
attribute :owner,       :kind_of => String, :default => "root"
attribute :group,       :kind_of => String, :default => "roleusers"
