#!/bin/env python2.4
import os

# Test if the process is already running
running = False
try:
    # Try to read pid file
    pid = open('/home/gt4d/webapps/trc/log/mongrel.pid').read()
    # Check if this process is up
    lines = os.popen('ps -p %s' % pid).readlines()
    if len(lines) > 1:
        running = True
    else:
        # Delete pid file
        os.remove('/home/gt4d/webapps/trc/log/mongrel.pid')
except IOError:
    pass

print "Content-type: text/html\r\n"
if running:
    print """<html><head><META HTTP-EQUIV="Refresh" CONTENT="2; URL=."></head><body>
    Site is starting ...<a href=".">click here<a></body></html>"""
else:
    print """<html><head><META HTTP-EQUIV="Refresh" CONTENT="2; URL=."></head><body>
    Restarting site ...<a href=".">click here<a></body></html>"""
    os.setpgid(os.getpid(), 0)
    os.system('/usr/local/bin/mongrel_rails start -d -e production -P /home/gt4d/webapps/trc/log/mongrel.pid -p 29628')
