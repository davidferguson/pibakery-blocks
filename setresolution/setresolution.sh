#!/bin/bash
filepath="/boot/config.txt";

valuename="hdmi_group" newvalue="$1";
sed -i "s+^#\?\(${valuename}\)=.*$+\1=${newvalue}+" "${filepath}";

valuename="hdmi_mode" newvalue="$2";
sed -i "s+^#\?\(${valuename}\)=.*$+\1=${newvalue}+" "${filepath}";

valuename="disable_overscan" newvalue="$3";
sed -i "s+^#\?\(${valuename}\)=.*$+\1=${newvalue}+" "${filepath}";