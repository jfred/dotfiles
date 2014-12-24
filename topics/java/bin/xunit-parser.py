#!/usr/bin/env python
import sys
import re
import xunitparser
import pprint

ts, tr = xunitparser.parse(open(sys.argv[1]))

for tc in ts:
    if not tc.good:
        msg = 'FAILED'
        if tc.trace:
            for line in tc.trace.split('\n'):
                if tc.classname in line:
                    filename, lineno = re.match('.*\((.*):(.*)\)',line).group(1,2)
                    break
            
        print('"%(filename)s", line %(lineno)s: %(message)s' % {
            'filename': filename,
            'lineno': lineno,
            'message': tc.message
            })
    
