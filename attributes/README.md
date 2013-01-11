the ugly way we use attributes
==============

there are two separate encrypted files that support decryption - secrets-np and secrets-prod. 

both of these files are encrypted with a different gpg key.

since non prod can be many different environments, these files will follow the nodegroup naming standard

qa-r3:
  key1: value1
  key2: value2
  key3: value3
qa-r3:
  key1: value4
  key2: value5
  key3: value6
