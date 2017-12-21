# UniFi-Timelapse

## Create time lapse video from UniFi camera. 

This was never developed for public consumption, so it’s messy with not much error checking.  If someone wants to fork it, clean it up, and keep it up to date, please be my guest. Consider the License public domain, so you can do anything you like with the code.

## Install

Log into the camera and enable "Enable Anonymous Snapshot", then go to `http://camera.ip.address/Snap.jpeg` and check you see a still image. If not, fix what’s wrong as nothing else will work.

Place the bash scripts into a directory of your choice.
Edit ```unifi-timelapse.sh```

Change the below to a directory of your choice. All jpeg images will be stored here under the camera name.

```
SNAP_BASE="/mnt/hgfs/Disk2/UniFi-Snaps”
``` 

Change the below to the IP address and names of your cameras
```
CAMS["Front Door"]="http://192.1.1.1/snap.jpeg"
CAMS["Back Door"]="http://192.1.1.2/snap.jpeg"
CAMS["Driveway"]="http://192.1.1.3/snap.jpeg"
CAMS["Back Garden"]="http://192.1.1.4/snap.jpeg"
```

Now check the script will save snaps :-

```unifi-timelapse savesnap "Front Door" "Driveway"```

That should save a still image to the directry lieted in the `SNAP_BASE` variable. If it worked setup a cron job to execute that script every time you want to save an image.
This example is crontab to save an image every minute
```
*/1 * * * * /path/to/script/unifi-timelapse savesnap "Front Door" "Driveway"
```

Then every time you want to make a video, simply execute
```
unifi-timelapse.sh “camera name” today
```
That will create a time-lapse of all todays images.  Options are `today` `yesterday` `all` `file` hopefully that’s self explanatory. The `file` option should be a text file with a list of the images you want included, one per line.
