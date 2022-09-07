#!/bin/sh

#  wattage.sh
#  Quotes
#
#  Created by Kipp Dunn on 9/6/22.
#  
ioreg -rw0 -c AppleSmartBattery | grep BatteryData | grep -o '"AdapterPower"=[0-9]*' | cut -c 16- | xargs -I %  lldb --batch -o "    print/f %" | grep -o '$0 = [0-9.]*' | cut -c 6-
