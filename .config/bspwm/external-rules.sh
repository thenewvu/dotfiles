#! /bin/sh

wid=$1
class=$2
instance=$3

# chrome app - floating for youtube
if [[ "$instance" = "crx_jjphmlaoffndcnecccgemfdaaoighkel" ]] ; then
  echo "state=floating"
# chrome app - google keep
elif [[ "$instance" = "crx_cppbapjpgdfdejdlabdnhkeocdjegifp" ]] ; then
  echo "state=floating"
elif [[ "$class" = "mpv" ]] ; then
  echo "state=floating"
fi
