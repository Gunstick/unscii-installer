#!/bin/bash
# (c) Gunstick/ULM 2022 GPL v3.0
while read fonturl
do
  wget -q -O "$(basename "$fonturl")" --show-progress "$fonturl"
  if [ $? -ne 0 ]
  then
    echo "Error downloading $fonturl"
  fi
done <<EOF
http://viznut.fi/unscii/unscii-16.ttf
http://viznut.fi/unscii/unscii-16-full.ttf
http://viznut.fi/unscii/unscii-8.ttf
http://viznut.fi/unscii/unscii-8-tall.ttf
http://viznut.fi/unscii/unscii-8-thin.ttf
http://viznut.fi/unscii/unscii-8-alt.ttf
http://viznut.fi/unscii/unscii-8-mcr.ttf
http://viznut.fi/unscii/unscii-8-fantasy.ttf
EOF
echo "Downloaded fonts:"
ls *ttf
# https://askubuntu.com/questions/3697/how-do-i-install-fonts
mkdir -p ~/.local/share/fonts
mv -n *.ttf ~/.local/share/fonts
if [ $(ls *ttf 2>/dev/null|wc -l) -ne 0 ]
then
  echo "could not move these fonts into ~/.local/share/fonts, probably already exists:"
  ls *ttf
  echo press return
  read a
fi
echo "unscii fonts installed:"
fc-list | grep unscii
# test
startvalue="1FB00"   # unicode begin
decstart="$((16#$startvalue))"
for row in {0..255..16}
do
  for col in {0..15}
  do
    printf '\U'$(printf '%x' $((decstart+row+col)))" "
  done
  printf "\n\n"
done 
