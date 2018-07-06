# RPI 3 WIFI AP + Station

The install script, `self-installer.sh` is a little special in that it 
contains an embedded tar.gz "file" with the contents of `./etc` and `./files/installer`.
If you make any changes to `./etc` or to `./files/installer`, then run

```bash
./make-self-installer.sh
```

which will create a new `self-installer.sh`.  Then re-import this block into PiBakery
to get the changes.
