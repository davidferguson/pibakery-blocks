#!/usr/bin/python
import sys
import os

env_filename = "/etc/profile.d/proxy.sh"

http = sys.argv[1]
https = sys.argv[2]
ftp = sys.argv[3]

text_env = """
export http_proxy={0}
export https_proxy={1}
export ftp_proxy={2}

export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export FTP_PROXY=$ftp_proxy
""".format(http,https,ftp)

# write the text to the file
with open(env_filename, "w") as f:
    f.write(text_env)

# run the script
os.system("bash /etc/profile.d/proxy.sh")

# For apt-get the proxy has to be set specifically
apt_filename = "/etc/apt/apt.conf.d/90proxy"

text_apt = """
Acquire::http {{ Proxy "{0}"; }};
""".format(http)

# write the text to the file
with open(apt_filename, "w") as f:
    f.write(text_apt)
