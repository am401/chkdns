import sys
import socket
import re

#  Take the command line argument
domain = sys.argv[1]
domain.startswith("http?://")
#  Strip protocol and path from URL
domain = domain.split("//")[-1].split("/")[0]

#  Alternate method of stripping protocol and path from URL
#domain = re.sub(r'https?://', '', domain)
#domain = domain.split('/')[0]

#  Obtain the IP address for the domain passed to $domain
ip_address = socket.gethostbyname_ex(domain)[2]

for ip in ip_address:
        print('\x1b[1;36;40m' + ip + '\x1b[0m')

