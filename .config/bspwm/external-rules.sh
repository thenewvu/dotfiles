#! /bin/sh

wid=$1
class=$2
instance=$3

# make windows transparent
if [[ `cat /tmp/boring` = "true" || "$class" = "Bar" ]] ; then
  transset-df -i $wid -x 0.5
fi

# chrome app - floating for youtube
if [[ "$instance" = "crx_jjphmlaoffndcnecccgemfdaaoighkel" ]] ; then
  echo "state=floating"
# chrome app - google keep
elif [[ "$instance" = "crx_cppbapjpgdfdejdlabdnhkeocdjegifp" ]] ; then
  echo "state=floating"
elif [[ "$class" = "mpv" ]] ; then
  echo "state=floating layer=above"
fi
