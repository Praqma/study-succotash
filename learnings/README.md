# Lessons learned

## ERROR: OpenSSL::PKey::RSAError: private key needed.
This message indicates that you need to reset your key on the chef server:
* Go to your chef server, Administration, Users, Reset key
* Download the newly generated key to your .chef directory
