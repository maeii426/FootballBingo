# \\165.91.33.68\stat-share\ftb\tam.xml
USING_WINDOWS_OS = False


network_path = '\\\\165.91.33.68'
file_path = '\\stat-share\\ftb\\tam.xml'

network_path_linux = '\\165.91.33.68'
file_path_linux = '\stat-share\\ftb\\tam.xml'

ip = '165.91.33.68'
username = 'stats'
password = 'stats99'

target_filename = 'tempgame.xml'

import tempfile
import subprocess
import shutil
from smb.SMBConnection import SMBConnection

#try:
print("Connection attempt....")
print("Must be behind TAMU firewall")

try:
    if USING_WINDOWS_OS:
    # Windows code to access file share
        winCMD = 'NET USE ' + network_path + ' /User:' + username + ' ' + password
        subprocess.Popen(winCMD, stdout=subprocess.PIPE, shell=True)
    else:
    # Linux access to windows file share
        print("1")
        conn = SMBConnection(username, password, "165.91.33.68", "", use_ntlm_v2 = True)
        print("2")
        assert conn.connect("165.91.33.68")# + file_path_linux)
        print("3")
        file_obj = tempfile.NamedTemporaryFile()
        file_attributes, filesize = conn.retrieveFile('smbtest', '/rfc1001.txt', file_obj)
except:
	print("Doesn't handle if the share connect fails")
	# if the connection fails do something fancy
	
	
if USING_WINDOWS_OS:
    shutil.copyfile(network_path + file_path, target_filename)
else:
    file = open(network_path_linux + file_path_linux)