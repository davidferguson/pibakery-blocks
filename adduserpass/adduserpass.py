#!/usr/bin/python
# Thanks to Filipe Pina on StackOverflow

import subprocess,crypt,random, sys

login = sys.argv[1]
password = sys.argv[2]

ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ./"
salt = ''.join(random.choice(ALPHABET) for i in range(16))

shadow_password = crypt.crypt(password,'$6$'+salt+'$')

r = subprocess.call(('useradd', '-m', '-U', login))
if r ==9:
	print 'Username in use for '+login+', changing password'
	
r = subprocess.call(('usermod', '-p', shadow_password, login))

if r != 0:
    print 'Error changing password for ' + login
