#!/usr/bin/env python

import sys
import os

#sys.path.insert(0, "/home/http/python")

#os.chdir("/home/http/tupi")

os.environ['DJANGO_SETTINGS_MODULE'] = "settings" 

from django.core.servers.fastcgi import runfastcgi

runfastcgi(method="threaded", daemonize="false")
