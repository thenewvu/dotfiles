#! /bin/sh

wid=$1
class=$2
instance=$3

# make bar transparent
if [[ "$class" = "Bar" ]] ; then
  transset-df -i $wid -x 0.8
elif [[ "$class" = "Termite" ]] ; then
  transset-df -i $wid -x 0.9
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
