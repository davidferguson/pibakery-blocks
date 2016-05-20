if [ -d $2 ]
then
  wget "$1" -P "$2"
else
  wget "$1" -O "$2"
fi