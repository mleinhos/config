#!/bin/bash

NAME=myvm

xl destroy $NAME
xl create $NAME.config

#killall ssh
killall gdbsx

domid=$(xl list | grep $NAME | awk '{print $2}')
 
echo "New domain $domid"

echo "You must run gdb now for the VM to resume."
gdbsx -a $domid 64 3333 &

