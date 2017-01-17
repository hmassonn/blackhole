#!/bin/sh
#IQN=`iscsictl list targets | grep iqn | awk {'print $1'}`
#iscsictl login $IQN

iscsictl modify target-config `iscsictl list targets | grep hmassonn | cut -d ' ' -f1` -auto-login enable
iscsictl login `iscsictl list targets | grep hmassonn | cut -d ' ' -f1`
iscsictl list target-config `iscsictl list targets | grep hmassonn | cut -d ' ' -f1`
