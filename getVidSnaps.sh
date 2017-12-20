#!/bin/sh

SNAP_BASE="/mnt/hgfs/Disk2/UniFi-Snaps"
DATE_EXT=`date '+%F %H:%M'`

getSnap() {

  snapDir="$SNAP_BASE/$1"
  if [ ! -d "$snapDir" ]; then
    mkdir -p "$snapDir"
    # check error here
  fi
  
  snapFile="$snapDir/$1 - $DATE_EXT.jpg"
  wget --quiet -O "$snapFile" "$2"
}

getSnap "Back Garden" http://xxx.xxx.xxx.xxx/snap.jpeg
#getSnap "Front Door" http://xxx.xxx.xxx.xxx/snap.jpeg
#getSnap "Camera3" http://xxx.xxx.xxx.xxx/snap.jpeg
