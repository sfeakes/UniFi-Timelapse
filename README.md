# UniFi-Timelapse

## Create time lapse video from UniFi camera. 

This was never developed for public consumption, so it’s messy with not much error checking.  If someone wants to fork it, clean it up, and keep it up to date, please be my guest. Consider the License public domain, so you can do anything you like with the code.

## Install

Log into the camera and enable "Enable Anonymous Snapshot", then go to `http://camera.ip.address/Snap.jpeg` and check you see a still image. If not, fix what’s wrong as nothing else will work.

Place the two bash scripts into a directory of your choice.
Edit ‘getVidSnaps’ and change 'SNAP_BASE="/mnt/hgfs/Disk2/UniFi-Snaps”’ to a directory of your choice. All jpeg images will be stored here under the camera name.
At the bottom of the file, simply change / add the lines for each camera in the format. `getSnap “Camera Name" http://xxx.xxx.xxx.xxx/snap.jpeg`. Obviously change `camera name` to the name of your camera and xxx.xxx.xxx.xxx to the camera’s IP address.

Setup a cron job to execute that script every time you want to save an image.
This example is crontab to save an image every minute
```*/1 * * * * /mnt/hgfs/Disk2/UniFi-Snaps/getVidSnaps.sh```

Edit `createVid.sh`and make the exact same change to `SNAP_BASE="/mnt/hgfs/Disk2/UniFi-Snaps”` as you made to getVidSnaps.

Then every time you want to make a video, simply execute
```
createVid.sh “camera name” today
```
That will create a time-lapse of all todays images.  Options are `today` `yesterday` `all` `file` hopefully that’s self explanatory. The `file` option should be a text file with a list of the images you want included, one per line.
