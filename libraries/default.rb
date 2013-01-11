# I don't know whether or not this is too ugly to include here.
class Cryptools
  # usage:
    # to get the content of an encrypted file:
      # ucrypt = Cryptools.unencrypt_gpg('input_file', 'gpg_key', 'name')
      # then write a new file with the content being the ucrypt string
  def self.is_gpg_encrypted?(file)
    output = `file -b #{file}`.downcase.strip
    case output
      when "gpg encrypted data" then return true
      else false
    end
  end

  def self.unencrypt_gpg(infile, key, name)
    ucrypt = `gpg -q --yes -r #{name} --secret-keyring #{key} --decrypt #{infile}`
    return ucrypt
  end

  def self.unencrypt_file(infile, outfile, key, name)
    return system("gpg -q --yes -r #{name} --secret-keyring #{key} -o #{outfile} --decrypt #{infile}")
  end

  def self.encrypt_gpg(infile, key, name)
    crypt = `gpg -q --yes -r #{name} --secret-keyring #{key} --encrypt #{infile}`
    return crypt
  end
end
