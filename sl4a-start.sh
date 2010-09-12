#!/bin/sh -x

# see http://code.google.com/p/android-scripting/wiki/RemoteControl

adb shell \
am start -a com.googlecode.android_scripting.action.LAUNCH_SERVER -n com.googlecode.android_scripting/.activity.ScriptingLayerServiceLauncher --ez com.googlecode.android_scripting.extra.USE_PUBLIC_IP true
adb logcat | grep sl4a.JsonRpcServer
