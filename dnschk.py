import sys
import socket

domain = sys.argv[1]
ip_address = socket.gethostbyname_ex(domain)[2]
print(ip_address)
