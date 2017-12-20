#!/bin/bash

SNAP_BASE="/mnt/hgfs/Disk2/UniFi-Snaps"
OUT_DIR="$SNAP_BASE/timelapse"
DATE_EXT=`date '+%F %H:%M'`


createDir()
{
  if [ ! -d "$1" ]; then
    mkdir "$1"
    # check error here
  fi  
}


createMovie()
{
  snapDir="$SNAP_BASE/$1"
  snapTemp="$snapDir/temp-$DATE_EXT"
  snapFileList="$snapDir/temp-$DATE_EXT/files.list"
  
  if [ ! -d "$snapDir" ]; then
    echo "Error : No media files in '$snapDir'"
    exit 2
  fi

  createDir "$snapTemp"

  if [ "$2" = "today" ]; then
    echo "Today"
    ls "$snapDir/"*`date '+%F'`*.jpg | sort > "$snapFileList"
  elif [ "$2" = "yesterday" ]; then
    echo "Yesterday"
    ls "$snapDir/"*`date '+%F' -d "1 day ago"`*.jpg | sort > "$snapFileList"
  elif [ "$2" = "file" ]; then
    if [ ! -f "$3" ]; then
      echo "ERROR file '$3' not found"
      exit 1
    fi
    echo "File"
    cp "$3" "$snapFileList"
  else
    echo "all"
    `ls "$snapDir/"*.jpg | sort > "$snapFileList"`
  fi

  # need to chance current dir so links work over network mounts
  cwd=`pwd`
  cd "$snapTemp"
  x=1
  #for file in $snapSearch; do
  while IFS= read -r file; do
    counter=$(printf %06d $x)
    ln -s "../`basename "$file"`" "./$counter.jpg"
    x=$(($x+1))
  done < "$snapFileList"
  #done

  if [ $x -eq 1 ]; then
    echo "ERROR no files found"
    exit 2
  fi

  createDir "$OUT_DIR"
  outfile="$OUT_DIR/$1 - $DATE_EXT.mp4"

  ffmpeg -r 15 -start_number 1 -i "$snapTemp/"%06d.jpg -c:v libx264 -preset slow -crf 18 -c:a copy -pix_fmt yuv420p "$outfile" -hide_banner -loglevel panic

  echo "Created $outfile"

  rm -rf "$snapTemp"
  cd $cwd   # Not needed, just force of habit
}


if [ "$2" = "" ]; then
  echo "Two params required.  \"cam name\" <all|yesterday|today|file>"
else
  createMovie "$1" "$2" "$3"
fi


