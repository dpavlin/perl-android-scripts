#!/bin/sh

# see http://code.google.com/p/android-scripting/wiki/RemoteControl

# start with:
#
# $ . sl4a-start.sh
#
# and you will get AP_HOST and AP_PORT in enviroment

public=""
test ! -z && public="--ez com.googlecode.android_scripting.extra.USE_PUBLIC_IP true"

adb shell \
am start -a com.googlecode.android_scripting.action.LAUNCH_SERVER -n com.googlecode.android_scripting/.activity.ScriptingLayerServiceLauncher $public

sleep 3

server=`adb logcat -d | grep sl4a.JsonRpcServer | grep "Bound to" | sed 's/^.*Bound to //' | tr -d '\r' | tail -1`

echo "SL4A bound to $server"

host=`echo $server | cut -d: -f1`
port=`echo $server | cut -d: -f2`

if [ "$host" == "127.0.0.1" ] ; then
	echo "not public IP, forwarding port $port"
	adb forward tcp:$port tcp:$port
fi

export AP_HOST=$host
export AP_PORT=$port

echo "AP_HOST=$AP_HOST AP_PORT=$AP_PORT"
