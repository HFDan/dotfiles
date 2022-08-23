#!/usr/bin/env python3

import sys
import os
import subprocess

if len(sys.argv) > 1:
  volume_to_set_to: float = float(sys.argv[1])
  os.system(f"playerctl volume {volume_to_set_to/100}")
else:
  got_vol: float = 0.0
  p = subprocess.Popen(['playerctl', 'volume'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  out, err = p.communicate()
  got_vol = float(out)
  print(f"{int(got_vol*100)}")
