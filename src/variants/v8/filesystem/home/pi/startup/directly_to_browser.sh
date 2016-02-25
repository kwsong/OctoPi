#!/bin/sh
xset -dpms
xset s off
xset s noblank

URL="http://localhost:8000"
VER=`cat /proc/cpuinfo |grep "ARMv7" >/dev/null 2>/dev/null && echo 1 || echo 0`

# Hide the cursor
#xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )
matchbox-window-manager -use_titlebar no -use_cursor no &
unclutter -idle 0 &

while true; do
if [ "$VER" -eq "1" ]; then
#RPI-2 board detected
sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium/Default/Preferences
#chromium --noerrdialogs --kiosk --user-data-dir $URL --incognito
/usr/bin/chromium-browser \
    --disable \
    --disable-infobars \
    --noerrdialogs \
    --no-sandbox \
    --user-data-dir \
    --incognito \
    --kiosk $URL > /tmp/chro.log 2>/tmp/chro_err.log
else
   /usr/bin/midori -e Fullscreen -a $URL
fi
done
